Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69444F50D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843497AbiDFBlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387286AbiDENO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:14:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6436129E8D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:19:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r11-20020a1c440b000000b0038ccb70e239so1449416wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iv3G8VxZx5uUW10Aa/SoQjHLkjzS6X/JRRMUNB++nm4=;
        b=H/L3OQMeen52BUNQ5Bl/Ov35nUFCexbkvHy+qSZ9R+NTndD9/fWvLhkd7qRqPaaxxo
         YaUFjkbO/yWk913YRU6CE268yzl888wroVIJYTVHDuJW3MRlJsDPRaXf3ckb3tG0Xw/w
         l9o2OfuO9QW2XJm3jETBp/lZ23EIxiKAUNFqYXpNQICdquiPLetD0yXQLs5OacEaurCZ
         AWE+zRabGaf3y03Mt293ym6Pto/PdZdo5LEsmFqok9j2iVeLDYKG9eBdhsFGfNNiA7H1
         YoPrDs5/sThnghLsFb4sXsfS7WMhfkb5ns2H0LJhb0UBQsgm+sCJA/2T9fsOMPpAwuwD
         pqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iv3G8VxZx5uUW10Aa/SoQjHLkjzS6X/JRRMUNB++nm4=;
        b=8PsjD+mKtRG8JE03B3uMKpNi5kxCYcwf6qGCiReeQlXtgy8K0+5vF1vML2mGsQtdDz
         thxcHvIzkXfUboOpjzsuGXJ23TOQM/n8zJG0V+O/sBaKfAWZjK+t8Wtd45w59wrE94kd
         qAYbzaQDPtashlzyTB8g4k2o9pkWDneUbaB97q8foy7fGv+NgLzcPTYyStCoYGdXRFdS
         esFKq8hdiDG1MuWTGkk5UCpVeflyv9dRUmlKWxQLRYjWkq0h9cYnyeD8z2RY91pCrE1I
         19IOZ9dAyMURq8VYQNOBjnJELEWYIcZkxTDIrZWiYcZgo0vdyM6uZTpqI7aELekOul+1
         RCTg==
X-Gm-Message-State: AOAM531GlqEG0BZhHvaM77hAZ+juob7PjaqBACzE1kjVjRl/p7/DVyps
        ek4PF6z8n2M4+ebIh78T7Eo=
X-Google-Smtp-Source: ABdhPJwfSPW4XgO5Vv8pHu5Chw0EfBEkhq5xUjUUz91WYo0RT4Yh0OeIQJznb4HBMqJlv87nYWn8UQ==
X-Received: by 2002:a7b:c922:0:b0:383:e7e2:4a1a with SMTP id h2-20020a7bc922000000b00383e7e24a1amr2930238wml.51.1649161166363;
        Tue, 05 Apr 2022 05:19:26 -0700 (PDT)
Received: from debian (host-78-145-97-89.as13285.net. [78.145.97.89])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b002061cf9eeafsm2291340wru.49.2022.04.05.05.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 05:19:25 -0700 (PDT)
Date:   Tue, 5 Apr 2022 13:19:24 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: Linux 5.18-rc1
Message-ID: <YkwzzANkBRzrYAuq@debian>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404022239.GA1186352@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 07:22:39PM -0700, Guenter Roeck wrote:
> On Sun, Apr 03, 2022 at 03:14:19PM -0700, Linus Torvalds wrote:
> > So here we are, two weeks later, and the merge window is closed.
> > 

<snip>

> > 
> > Go test, please,
> 
> Build results:
> 	total: 151 pass: 142 fail: 9
> Failed builds:
> 	alpha:allmodconfig
> 	arm:allmodconfig

Apart from the ones Guenter reported, arm imote2_defconfig fails due to:
28f74201e37c ("ARM: pxa: remove Intel Imote2 and Stargate 2 boards")


--
Regards
Sudip
