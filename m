Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06C562353
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiF3TjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbiF3TjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:39:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCCA3C4BF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:39:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a11so24416562ljb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CAIH/48VCAZZUEhRpfaRPTSaBdpuCbyHyIV69iiJf1M=;
        b=NZ/AMGulz2hyqnocDh00pNSYV77i4OLEs4Zc78kNje9jg1YFHL85XL37htn5nn7X3M
         YdSfh8iYxhB9Je5hiMfGdRdDekW7UU/17YaEmknMOJvTGzQu55Qc27h0smGOlfzfk9QD
         65PypKFNWbdl9LtcLsxfA5h9yiFJQ4Xg1YSjE5WxjtuuPx8AminJp2es+fdy3vj8A2MG
         q7IRmmj2TDui5qCAbsBOI/gp5FiE+4XWiTf/7LNIyhTF918tsd8MtB5Je35YcNqdfws1
         uPZyXWvfKJ0TYwsDEyctpUnhigdGevOrhcKS1x35XqQ1vaM3qm/oOqpbZjRxW6HZkq04
         klVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CAIH/48VCAZZUEhRpfaRPTSaBdpuCbyHyIV69iiJf1M=;
        b=sIK89M4Lgjs80PVtf4JOe8MjexrQnexl48M1lqVx/g4yrpncdtixKfKijSlxgZdb/G
         lLAkAppeDSFK8pQOkDuUOJQb30MeCws+4m7uaVo6FlLxyfhJOL/egw7bbZuJJANBEjJz
         cfPYaZbAgspKTcxZhhs2/j7qqC/bftqwSzw1NC000yt3j8+CpVDaYbz1b0FCbtNAqGQZ
         vxUZ71+Ow+U6Xz9F0ggIPyVDg2UQmhP+thLTg8j+9Xz1Vr/iDch1zz47eM62dAif9aGk
         0dxPNOama/D/OkuPFXGAglqIUZdABoMuHv7cbz4NB2tpAL2maD/iIFfi4YYmiDrv4X5D
         DOqg==
X-Gm-Message-State: AJIora8g68PHO7chdmfU1RDdfSRtoknTd5D+KYaGxiLQ7wWPilJosMYp
        Qt2KNoa5tHZckFBXXcNfTVKrRc5Egrj4tz3K6nM=
X-Google-Smtp-Source: AGRyM1s47M5WGfJN0+KKq/fUwykUydGH0s7rxFToTn9s8NVO7n2G5xbDpEK40rJSyVs2RT5kB+yoJarjz8agd8xpj8M=
X-Received: by 2002:a2e:880b:0:b0:25b:8aaf:d873 with SMTP id
 x11-20020a2e880b000000b0025b8aafd873mr6017949ljh.332.1656617944339; Thu, 30
 Jun 2022 12:39:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:570e:0:0:0:0:0 with HTTP; Thu, 30 Jun 2022 12:39:03
 -0700 (PDT)
Reply-To: pstefanopessina80@gmail.com
From:   STEFANO PESSINA <wambuachristina2@gmail.com>
Date:   Thu, 30 Jun 2022 22:39:03 +0300
Message-ID: <CAAqesQ7PNWsCSdU2tN8785k-yh599h39J_6sAqYkwPC6Xo_ALQ@mail.gmail.com>
Subject: donation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20

Congratulations!
The sum of =E2=82=AC1,500,000.00 has been donated to you by STEFANO PESSINA=
.
Kindly get back for more info via pstefanopessina80@gmail.com
