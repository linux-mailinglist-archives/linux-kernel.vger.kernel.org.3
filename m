Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2434FB62F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbiDKIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiDKIj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:39:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F693EA89
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:37:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r7so9403723wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GmeaL9LDzXt1lPoYGs5/whgdTpbkv+uMLJxNx67on5U=;
        b=En1vDoVLLQ4z3hVfItCZlMRphp0aoIeyvop6pZQ99iOwzMH5A3TI1Y0hkHiuygYWJO
         W0kkWHK1yWNXviBp/bUinRXdJewpQTwevUxvBoXbKbci5bLfrzQfE0FRRnN3v+YcgH79
         azH4p5jr19pAMhsZZXM1slPZnEaEdIpsPlDO8sl41Esei69Ni/UQ9cNerAE9MTf3gRg6
         5CI1AVaNcHO9c5yJnpMQoY56ZAV3QuPiKh6LReY7NWqHAmSkakaKr3yrl9gl/vlMx+0n
         tAm/3DlnYLBS9qcqN3/0fbY9mmpqJNujSthe5ex2K8OygUBOfFwgyoHBSQ1ZeH3lP7cB
         Q77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GmeaL9LDzXt1lPoYGs5/whgdTpbkv+uMLJxNx67on5U=;
        b=gPy2n0opmOuFAIUpc4kVDFDTN87mo3XYBCtAwp83ZBHpNEgv0Q0fy92X9ZUvgCkSH6
         WlUOEhXVBZIVJRe6CvE5Coonn94hE/nlwe0af4zSF/VxSvXwo/GFT+Qd+eNJYEtDlddy
         Z19twd8/S/my0zsnjfM/FIhELzIWc82ZtzZhNWzzFpI5eqS7Csq93tUt6UPaoTZ92ozW
         W8M3iZMIlsJ6wrlGlJiop9s9Cs2IpRgQOMPh7iHGhBoxSgdW3zDm/fO7YfWu1mWBK21u
         Op18viGNJCB8ee3INNb0h+/qpU9UqXmUzZRltJ+WI08um8bEB3ksUsTtH3+9PreJ96py
         3J/A==
X-Gm-Message-State: AOAM533EE+gkhs+kKZG/I4ZsCKFILvghhtMtG2+Qayqi1uzBR9brPPHw
        Sc/spWggN69p5xVZ1zSQulJYquT4Yzejmw==
X-Google-Smtp-Source: ABdhPJxYx2mY9F3f959XsRTlxs/Nym64Waidy4p3tUy1+g4fDUkZw66J/o+5dxLZJ+oc0hIHE7/jqw==
X-Received: by 2002:a05:600c:682:b0:38e:b64f:f11d with SMTP id a2-20020a05600c068200b0038eb64ff11dmr7210510wmn.202.1649666232377;
        Mon, 11 Apr 2022 01:37:12 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm19621474wmp.13.2022.04.11.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:37:11 -0700 (PDT)
Date:   Mon, 11 Apr 2022 10:37:10 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     jernej.skrabec@gmail.com, samuel@sholland.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 00/19] crypto: allwinner: lots of fixes
Message-ID: <YlPotuZilcnenky0@Red>
References: <20220317205605.3924836-1-clabbe@baylibre.com>
 <Yk/xNIjjINj9Hvki@gondor.apana.org.au>
 <YlPasmjElADX+7u5@Red>
 <YlPbbM7RurahUMn/@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlPbbM7RurahUMn/@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Apr 11, 2022 at 03:40:28PM +0800, Herbert Xu a écrit :
> On Mon, Apr 11, 2022 at 09:37:22AM +0200, LABBE Corentin wrote:
> >
> > Coul you give me more details ?
> > I do not have any sparse error.
> 
> Did you compile with C=1? Anyway, for a start hash_pad is broken as
> it tries to store an le32 value into a u32.

Yes I compile with both W=1 and C=1.
But rigth, hash_pad takes a u32 but the origin variable bf is __le32, so perhaps it is why sparse dont see a problem.
Anyway I will fix hash_pad declaration.

Thanks
