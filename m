Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BFE4E5959
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbiCWTrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbiCWTrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077E18BE1C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A00C0615BD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C078DC340E8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:45:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NXA1qI36"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648064734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwg+qxFHZRnPjdPTzV0MenWDKtE/+cq1lWxamf8sySg=;
        b=NXA1qI36SCQcapT7abCeBx4U7XY7XBmiV0Jd3bzVyAXsNYCfnS8+Q6qu6ByZZs9yKjO/Px
        cDwk6xIYmr2U8pInr1i3w+U3wF2hItDy2NMVyTew8Dsu2oiT2cjrGCCFbcodnUNoEh/06e
        6E53gGHgnTpd20ZXazsr7l4ERkTKr5k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d8e51a92 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 19:45:34 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2e5827a76f4so29521307b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:45:34 -0700 (PDT)
X-Gm-Message-State: AOAM533FUr95MUUKOjH/i0DS3aVLB9W2ipVj+jUL3MvkNMnuD50RzQub
        w5rwbTBnG/kz3ldOP73xLagcxpskKS01MkASwdo=
X-Google-Smtp-Source: ABdhPJw027su77izYzWCjdxmO/5j44xOY2E1CeGSlB89lwfUaOCDNQzMZFQPlAhTdEZZSDqzaWBjVUNcdBQghDnamjc=
X-Received: by 2002:a0d:c681:0:b0:2db:9ffe:1f00 with SMTP id
 i123-20020a0dc681000000b002db9ffe1f00mr1756667ywd.100.1648064733566; Wed, 23
 Mar 2022 12:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220323042336.148775-1-Jason@zx2c4.com> <Yjt0AX8st/gE00CM@owl.dominikbrodowski.net>
In-Reply-To: <Yjt0AX8st/gE00CM@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 23 Mar 2022 13:45:22 -0600
X-Gmail-Original-Message-ID: <CAHmME9r7+tU6sU80opW-cyw4srsnOpLTsUKUv2Qdfs-DtPYekw@mail.gmail.com>
Message-ID: <CAHmME9r7+tU6sU80opW-cyw4srsnOpLTsUKUv2Qdfs-DtPYekw@mail.gmail.com>
Subject: Re: [PATCH] random: re-add removed comment about get_random_{u32,u64} reseeding
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
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

Hi Dominik,

Good point; might as well take this opportunity to firm up that
wording. How about:

"... and do not invoke reseeding until the buffer is emptied."

Jason
