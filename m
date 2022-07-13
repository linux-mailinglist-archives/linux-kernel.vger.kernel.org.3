Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757AF572CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiGME7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiGME6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:58:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17662DB2E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:58:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bp15so7574379ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Rwk5fL1nmMK/htiTOjUxWirSzLzg3Ni4nhkxdX7Azzc=;
        b=ginaMvHS1B9t8PH0QsHz6hp+2h1MtjZyuHJuBGpfcqrCr6wEGE6/sZsYaL9LpDC/pL
         Zv5J1K12xIKUYZchR0b/pjS6+sAA+y2BZIHXff7kqhFLYuCUfleVNxz5N1DWJzYEkH8n
         HWqJAmb5zycP+++tTj8zb3gNGKTsSIglAm3QLS93Jqs76FtuJ9oQcssZiR2zPZbegU8p
         PnDWutiHd2aJv9e0uqGu8II4W6b5Zf93p1TOK4FDKLFq6JXuaYLsCCKEk4pOX0LLEG5F
         qYhnP3CMPj7sOfVb3JMfXdraX0qcD302iRVhZ6epw+YhmVYfn0pV+HlgUfatk1oSLoGx
         7KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Rwk5fL1nmMK/htiTOjUxWirSzLzg3Ni4nhkxdX7Azzc=;
        b=IdWzTltKklEOigszInJU7vWvdgKONYCc1f9q/wEbyNHuaZ254D/XVRcGv7fzuZf2Io
         Ah+1uUtWLOJzfUYA/wqZCOzlXfeV+B0Y2d8ySgZd01TkJhCBIwUtLzRO5yOSJi2FSftV
         0kryzmB5JcAT/+t8MKdTBA8ARPxdLBmXprUBRZ5fg0RDuiTADr//oA53gK5AuoDawHd+
         vB+PtvNm7CwbxLByMyLYBzCqx2c8inR6slsBEsucfhi2EEOOnlyHN6DSYyf9OLA1+AzI
         m0aSajsncdjPkZNi8VxMSpRxXLvujPSDjY6VpZ4RBwV+T6frSaaH/wyqNBN2weRYR4rj
         hUmg==
X-Gm-Message-State: AJIora/RFLDCGsmhKmdWE/sciz230a3Tv5TosHNZWZPDgrbjak1XKrUK
        Qo4hV0El9ZgD7CBxZ8bFxyYpE1dvSd4=
X-Google-Smtp-Source: AGRyM1sLrNEpc2DwxbE3ea/c15iNPPhsweXzmtrY53NrIMDXUeeRC/6xA1iY9/dKE6NCuiuk2NEJ6Q==
X-Received: by 2002:a17:907:3e11:b0:72b:49d1:2054 with SMTP id hp17-20020a1709073e1100b0072b49d12054mr1618285ejc.78.1657688305557;
        Tue, 12 Jul 2022 21:58:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id kw24-20020a170907771800b006fe8ac6bc69sm4526792ejc.140.2022.07.12.21.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:58:25 -0700 (PDT)
Date:   Wed, 13 Jul 2022 06:58:17 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] staging: vt6655: Convert four macros to functions
Message-ID: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert four multiline macros for bit manipulations to functions.
checkpatch.pl does not accept multiline macros. 

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (13):
  staging: vt6655: Rename byRegOfs to reg_offset in four macros
  staging: vt6655: Rename byBits to bit_mask in two macros
  staging: vt6655: Rename wBits to bit_mask in two macros
  staging: vt6655: Rename byData to reg_value in two macros
  staging: vt6655: Rename wData to reg_value in two macros
  staging: vt6655: Rename MACvRegBitsOn
  staging: vt6655: Rename MACvWordRegBitsOn
  staging: vt6655: Rename MACvRegBitsOff
  staging: vt6655: Rename MACvWordRegBitsOff
  staging: vt6655: Convert macro vt6655_mac_reg_bits_on to function
  staging: vt6655: Convert macro vt6655_mac_word_reg_bits_on to function
  staging: vt6655: Convert macro vt6655_mac_reg_bits_off to function
  staging: vt6655: Convert macro vt6655_mac_word_reg_bits_off to
    function

 drivers/staging/vt6655/baseband.c    |  8 +++---
 drivers/staging/vt6655/card.c        | 32 ++++++++++-----------
 drivers/staging/vt6655/channel.c     |  2 +-
 drivers/staging/vt6655/device_main.c | 37 ++++++++++++------------
 drivers/staging/vt6655/mac.c         | 42 ++++++++++++++++++++++++----
 drivers/staging/vt6655/mac.h         | 35 ++++-------------------
 drivers/staging/vt6655/power.c       | 21 +++++++-------
 drivers/staging/vt6655/rf.c          | 16 +++++------
 drivers/staging/vt6655/rxtx.c        |  2 +-
 9 files changed, 100 insertions(+), 95 deletions(-)

-- 
2.37.0

