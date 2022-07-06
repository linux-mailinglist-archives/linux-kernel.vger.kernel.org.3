Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F66569280
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGFTTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiGFTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:19:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94924F29
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:19:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u12so28707949eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=zAcGzWs5eFUSfcLvPQCXZ0dttFV0YKOa/siKsgyxWwo=;
        b=kUPUsLGTefIaMM17nQCIrX95u5qEJBDBwEVqjFwgrNCC8n/0CrxQDG6nEMAz0Hp/xp
         ewXNcELyKhyZJPeAXrf5tqPDeHwaxlJ9KYzMp4wN6SwptrF9CXRnr/B4TlW01pGUiyhw
         ngw9D6QIu5NTfw3fn6oUqszvng+10WJzGKUkvCOCEQBaFmZISAJ/+WvbpCuU85f2Zn53
         4/p78v4CGna4YljB5MXv24mQ+R9wUET2E981mrY0g4BdS4I/VA5zztDTeNF22oCqNaMs
         i0kg+VoLOzcPGkXoLD+kTEDh42Gwj//bJYAwvPM2N7ATTjGwWw19TqsADYDnJw3HnJLD
         DNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=zAcGzWs5eFUSfcLvPQCXZ0dttFV0YKOa/siKsgyxWwo=;
        b=ycXxF3+gmCdnRPsFDnY3VA0mHv+H2T8JJQyPOZAiTReHvJjpq5FbpeoIaetTu+gK8Q
         Yz0hVabcWFa+UtNB6Ogi7bldO6zdC9tbs86f7VxObLsTRUgTv7e600uns/93T24WaaR4
         3FHU8G0/Q3/3p1EqeNJkHJSU9il0ms0+Ewom2+pFguYrMbrGgF9xcc/DHFUyRVtlpner
         2Ih2prTjDULtrsZAgKwmd+9wZleALBBwoZfLNG8FJcUdpTqCkNiSt6HYJ0SUbjvqB8eg
         c/QbB4H2DjLro4qxgIE4id9l7i0XPgCbt4ocaQshNeGo2ZJUsKa2a7ZChHwdD4Yz0KX5
         hCCg==
X-Gm-Message-State: AJIora9B5abgl50mwwGM6LjgFZX3qvmBsJfd7btZMArMc9VkWfsaH0tz
        RGDuLo2giES3EBTNoySZ2qU=
X-Google-Smtp-Source: AGRyM1tH85PhKldtjBepn66CCNtAvEAQu5ouk+3cAb4SwKlifDItFYCuw9VB+CGZUN/5rG0BZ3Q7PQ==
X-Received: by 2002:a17:907:7632:b0:72a:e615:30e3 with SMTP id jy18-20020a170907763200b0072ae61530e3mr9905460ejc.675.1657135139100;
        Wed, 06 Jul 2022 12:18:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id a9-20020aa7d909000000b0043a706d3a48sm6451971edr.76.2022.07.06.12.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:18:58 -0700 (PDT)
Date:   Wed, 6 Jul 2022 21:18:51 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: vt6655: Reduce similar statements when working
 with mac addr
Message-ID: <cover.1657134099.git.philipp.g.hortmann@gmail.com>
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

Use loop in vt6655_mac_read_ether_addr and vt6655_mac_write_bssid_addr
to avoid multiple similar statements.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (2):
  staging: vt6655: Use loop in vt6655_mac_write_bssid_addr
  staging: vt6655: Use loop in vt6655_mac_read_ether_addr

 drivers/staging/vt6655/device_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

-- 
2.37.0

