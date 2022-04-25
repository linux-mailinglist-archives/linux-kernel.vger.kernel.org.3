Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089E250E757
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbiDYRec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiDYReb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:34:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4121583A2;
        Mon, 25 Apr 2022 10:31:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w16so9751600ejb.13;
        Mon, 25 Apr 2022 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lx7n01ak613wao/PeGm56R/NraVbxP43cN5ZMlrScAY=;
        b=AWomtSHBSdpy50i/AiQTF1zEO67p6sM2bAacCXCIrE1EI3drNnFByVmoCM0R/JmKoO
         9gRqHx/Jriy3h41XZP3C0mqTsYL8gZMgJtK5YGBcBAM13cfn2MrAbHZu+63WnkD3pA0M
         DlNSX4/BDpYDhYNLxlybbm4UpTRPqmYx6mc07No5+cFKexLhyMCE/gp0T9Y5ncFf9UlH
         4t+iuhsW2AwBCXq8A0RuQ0hp4vsOhB/eDpAaHSKVH5lGxCZa6y2yaOCbBcLTm58dwi5j
         2mokqtKMGMcjlCu7ZnzTM9o/NOIptNtADfUmrdCmKHoADrK3HZRdkAov3SEu1yD6nH7F
         2pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lx7n01ak613wao/PeGm56R/NraVbxP43cN5ZMlrScAY=;
        b=yWaRFSJ4t1V7Q49cde4pYMMv83Ld2nWxCRXiwgtdeRmlRF2wUnNS7CsJ2q3tOrfAqK
         8ZfO85p+EuhzFYnTSpB2HAqVtQfVhRCphB0OhnjX/CUycBvYU10wZU9WSYhMBwuVbVaH
         xbu3eQyNvmHSticVzD5ZRNsgC3eIET0s1BaS89Fiya7BPMzrXu0hfwz6mZQB+zu2Vd8p
         aYZZ6YetqoA0BbdylwKaUlHVzkUe0/d7ToTV1ha+pLD1uC/4C2Np4QT8PEnYDfmuRg0J
         XoGYsKDbEXjyGGO0whsQ00vGuCWHSLwHUhUzGlqcQiZ056FsQhxxDLajlunr8QlYfLcp
         ahFg==
X-Gm-Message-State: AOAM532W6UEKmkjKrz4Ls9t4DiZf1NCfJ00SBXNyT1PHD0v9zkeLnNR6
        6hJ4tqpi2zzJXOZ7K30cV2c=
X-Google-Smtp-Source: ABdhPJxvwSr3XtyRkaaNJxbkUJVkHfpHdLP+s0Vc1yhmamJDJWKzG5omORC7vSs528rfOCd348xwnw==
X-Received: by 2002:a17:907:6289:b0:6e0:eb0c:8ee7 with SMTP id nd9-20020a170907628900b006e0eb0c8ee7mr16442680ejc.245.1650907883149;
        Mon, 25 Apr 2022 10:31:23 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm3884297ejd.11.2022.04.25.10.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:31:22 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH] bus: sunxi-rsb: Fix the return value of sunxi_rsb_device_create()
Date:   Mon, 25 Apr 2022 19:31:21 +0200
Message-ID: <2699804.BEx9A2HvPv@kista>
In-Reply-To: <ff0ae741-efc4-ba6f-d869-4cb8fb7149ad@sholland.org>
References: <ef2b9576350bba4c8e05e669e9535e9e2a415763.1650551719.git.christophe.jaillet@wanadoo.fr> <ff0ae741-efc4-ba6f-d869-4cb8fb7149ad@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 23. april 2022 ob 21:39:45 CEST je Samuel Holland napisal(a):
> On 4/21/22 9:35 AM, Christophe JAILLET wrote:
> > This code is really spurious.
> > It always returns an ERR_PTR, even when err is known to be 0 and calls
> > put_device() after a successful device_register() call.
> > 
> > It is likely that the return statement in the normal path is missing.
> > Add 'return rdev;' to fix it.
> 
> Thanks for the patch. This definitely looks to be the case.
> 
> > Fixes: d787dcdb9c8f ("bus: sunxi-rsb: Add driver for Allwinner Reduced 
Serial Bus")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> Tested-by: Samuel Holland <samuel@sholland.org>
> 

Applied to sunxi/fixes-for-5.18, thanks!

Best regards,
Jernej


