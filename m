Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9021D54A2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 01:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiFMXeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 19:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiFMXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:34:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972C31DE5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 16:34:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w17so1446552wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGYiKa6mXP0iZOXOQm7kCvDLrx3D14bnw7gw1UJaDHY=;
        b=Q+qj4tgzGC0W3T7fwxnpleP1RH8nFiUZ+6PltDb2osyo96YS0SaAnAL3gcP90t3uW9
         bVhf20bfbfCis0UBI4wK4VvpBeUJcK2hur0uOIuFfFULpyXglo5fZog21X1vnbEpj8R0
         f6+zigzJU2zRTaJoqvIYo5YzbnY8d+1qrYUFqmo4w+mQlSNvXR9i6eJaLInvHYOHb/aY
         6fiB6f/aniXoNg2wTLroaIxPaB3oJKzuSYKh5lCz+fTdshNh365tkVBZeJ4xIDEF/5mP
         8GqWXaXYU08FP4yV7maeP7Pw2orru0HBjntNANVH9SAmRzpHbIVUC2XlLdPpRG+uV9IO
         438A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGYiKa6mXP0iZOXOQm7kCvDLrx3D14bnw7gw1UJaDHY=;
        b=EFEztCNErZkf5Oc+OzvbTeMxGGoWk7bqHXnlM5x7HcHrFqVrNEnZd1iwNsZ6/w7Los
         vWkeNfxdqw4krpLjSIqbIISXuViF5FgavUW2e3bt9h3/KCBKH4YONbMK0c8in5eUw289
         CvXVSPte6AuUHAL0IwJB0GWiI9/1tF2VTZG0rTpbwIMvZAwihBliLKQiaiyzTKjEkoSc
         ne/CMguuGAYoFET4xwU9+QivE5E3ixzzw4rrOcg63UM01itN/pX4e4Ic76offUiKmnhM
         8hqBPfvy+Vs6H8NZuoPraQ+8GZE3dp1hwdM/PaGAchJJevegXRYLEsbIiDim523us3+T
         SzMw==
X-Gm-Message-State: AJIora8xTXwY7jKxsw33WC8jT0TDU/4Xln9fp/f6v0W955L4qBgG8hTB
        27cM+JasYgjCFEgkpkfJzzIYskMlfqXdVl/WNqzc
X-Google-Smtp-Source: AGRyM1vupl+waimCKX6BURP8frkXJ72r3v3eqI+2I8C6U17IP2g6be79mtg7PPeYV5f/qLsklq4q5mwUcv6/2+XPdpw=
X-Received: by 2002:a05:6000:1008:b0:210:3e9a:324c with SMTP id
 a8-20020a056000100800b002103e9a324cmr1964810wrx.89.1655163248675; Mon, 13 Jun
 2022 16:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220614082425.415adffc@canb.auug.org.au>
In-Reply-To: <20220614082425.415adffc@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Jun 2022 19:33:58 -0400
Message-ID: <CAHC9VhT9QUdfu5TCZcAuzcC8wBaA8VR2MKWiQE3RWEv5M65tJA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the selinux tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 6:24 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   e81ee824e8a1 ("docs: selinux: add '=' signs to kernel boot options")
>
> Fixes tag
>
>   Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> has these problem(s):
>
>   - No SHA1 recognised
>
> Also, I don't think that is a relevent or useful Fixes tag anyway.

Good point Stephen.  I just dropped the tag in the offending commit
and did a force push back to selinux/next; sorry for the noise.

-- 
paul-moore.com
