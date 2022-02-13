Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65114B3C10
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiBMPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 10:33:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiBMPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 10:33:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193235EDE8;
        Sun, 13 Feb 2022 07:33:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB46611C1;
        Sun, 13 Feb 2022 15:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A1EC340EB;
        Sun, 13 Feb 2022 15:33:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UKj7BsnJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644766413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4Zq7CU/3Ioz5ZQPY+h/YY0tWSvD90mWgBpOppgNMv0=;
        b=UKj7BsnJbmDvEZ5dJ9WlgiuU2IaKA/vmRlMA87NE+M8ZzCQGBPhp+U5bL4jBb2eeoVzr9b
        RHaom6PfzXOGnqreB5bclqdHGzopqTYBxBvChMtqN2B+PY3rhhldX/LUUOS9fQRM3eKFui
        HFpCKsHgm24gz2/y7W0AvyxAUqPDovs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 82b11059 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Feb 2022 15:33:33 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id o19so39037812ybc.12;
        Sun, 13 Feb 2022 07:33:33 -0800 (PST)
X-Gm-Message-State: AOAM530bloBsfHnWvWmONLrlMrQnJIZQi7hOqkkBkhFDRiIf1AnKVQcR
        oByTuj6CHkGXn9iaFDW8VVdhKOGCZm9EFDxysm0=
X-Google-Smtp-Source: ABdhPJwxmh/5d2icpn1RQ0dKtINRb/87wjVxa2OoK5oEk4n7knDBmkC/4OrkuTDhLUQMyuat9T/lClbwH2zUmJSeVfE=
X-Received: by 2002:a81:f002:: with SMTP id p2mr1154046ywm.404.1644766411524;
 Sun, 13 Feb 2022 07:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20220213152522.816777-1-Jason@zx2c4.com>
In-Reply-To: <20220213152522.816777-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Feb 2022 16:33:20 +0100
X-Gmail-Original-Message-ID: <CAHmME9r10tk8GoSd6ACU36h-q8+yaqfZCKCK6hyWiyo4Cehpvg@mail.gmail.com>
Message-ID: <CAHmME9r10tk8GoSd6ACU36h-q8+yaqfZCKCK6hyWiyo4Cehpvg@mail.gmail.com>
Subject: Re: [PATCH] random: pull add_hwgenerator_randomness() declaration
 into random.h
To:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     Matt Mackall <mpm@selenic.com>, Kalle Valo <kvalo@kernel.org>,
        ath9k-devel@qca.qualcomm.com, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 4:25 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> base-commit: 1b057ea07bdc88c5ab77cb9a9bc46f8690492c81
> prerequisite-patch-id: 722401baa02ea28022621588a48b701d116c0ad5
> prerequisite-patch-id: 8da951eeda7c2b69ccf9de465f6e33b6a32d1b8a
> prerequisite-patch-id: b252828d4fa0211224b7cac57b7a40a26847caf3
> prerequisite-patch-id: ac9dc6b642ecfd8d42394b06d7757e4076da3a35
> prerequisite-patch-id: aecaed912a18486ea6743ef94d86683d6ce35320
> prerequisite-patch-id: 74e4aea70835f508339e5223f1b01266698f1173
> prerequisite-patch-id: c315d7e54165666dae309e3ac6d5e666c6c97a33
> prerequisite-patch-id: 9b8f505cf7f6b605ba5143c801e3487149481cde
> prerequisite-patch-id: 7e48a52a3947c9d0d73a9867a7a3fb403e0e18ff
> prerequisite-patch-id: 6c5c60bf502f7691087241c32c3a898135783ea0
> prerequisite-patch-id: 80b04855c1ec5315d175cda682f528dab5db13ca
> prerequisite-patch-id: 00ec3b71c3fe248d55b00f1b210f029a221f295a
> prerequisite-patch-id: bac900c80e57d5fd5234b81a51359a76b378a9e9
> prerequisite-patch-id: d2c04ce2d5667557c6d863fb26ad046a16b86f7b
> prerequisite-patch-id: 4d98a7945c6dce30c3630f4668aa4b32ca53c971
> prerequisite-patch-id: bd93293024b6ad54ffaf1ae5bee3d805961e310d
> prerequisite-patch-id: e17118e66c1761f954fac49822231986f429e996
> prerequisite-patch-id: dca680875ff2a505bc35d8999fa18832d6cc378e
> prerequisite-patch-id: 798e5c78bbc4c0e1748a64496e4b139b6d5c85bf
> prerequisite-patch-id: d41dada11f57459add7e28d4a8714929b9ed07f8
> prerequisite-patch-id: a3159bc3b25f67ab0fb409dfc86373e3b6c3bc5e
> prerequisite-patch-id: 6d069efe964e32e90ac052183360f3b8e78fd6bd
> prerequisite-patch-id: 56253c1e4f608de542e26e5201f476a6e33c0166
> prerequisite-patch-id: 4cdc3b96e517592d6fdf493baaa49e032f0788c9
> prerequisite-patch-id: 4a7abc91a7dc1f6fdfb6a1bf310e0aeffee284ec

Git's automatic things went crazy; please discard this part of the patch.
