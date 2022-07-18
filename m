Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E15785BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiGROtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGROtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:49:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83404DF88
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:49:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso5866908wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=rPsqOiqXmhRP6L7tXLVtANoZJyxkacKQ4KIVHcNNa7c=;
        b=Pd62bwQulgO3UZaFXUYNcgVMBXGN37z20o1SMgEFyVcN1K9pcku+3CiLbpRlL9qBwk
         CDKmkjCBpLnzYeNRnRa3YqZ21ctL1t27vEzkR//bhlHEFCiVRKGk2mA8Oam+0npAbCVx
         zZ6h+GpkV9yLJwg/POogsQ1+WIWPK+xY11lSOcSJAFoBXVCMe/AVAjSwcK89Pu375r0N
         cvzbziTrna7sH3a+Ws7RugpUJdwZ9huU1+IRa7ylXG4YlF8y1GqM6j4gPeZfN7cgR0pk
         fJOZRy7ya+Nbz7WtN+dliBrx4V6xbeZ80Q7xslp8bwtQFiLqHrUzo2yWC9517MWVY8Yb
         BZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=rPsqOiqXmhRP6L7tXLVtANoZJyxkacKQ4KIVHcNNa7c=;
        b=lrgxPP/fhhG5aCR0U+L30YNT+9nMirFYra4LxuRZgn/UqtykDz4/tF5xHctPymybku
         L8Fie8gsKHLqL1VpbAP6cFHLuKgFbTM4rEwGYUDTBrsApY1qYSwLIXJz4FkovjpDxlUG
         dfoKCooVtG3ZS8H0jWBjVcsp4L3ZgCowDx7SNOxqyDRMnj+wSs3a9mOcpvJ9PgvGFVZF
         qxpm2P9ZtfktBu4trwT+zszwnBA0iIQZQZvjgvH+ceJrQ0hkNAhay+Kp4ZCK/uyxtiK9
         SQyG9NqllQtt6jlOpjO1aAGkuDuBKvTrht6t1+QPROvcyxyx8yr18Bcal0Jx0UXH7XjC
         h/KA==
X-Gm-Message-State: AJIora8xNVfI8Wee9gUX0FPROlXPmrs7YYHxZscGtVFWsO0mgsrCkXyq
        Ek2smsUqRaY59Wz/MfeqQVcG9PJkkso=
X-Google-Smtp-Source: AGRyM1sxdrKXZlko3F3A7awiTm3NLlUCzg9/YIOUuLXYKu+ceYSS9tBeeZg8Ae4M8d+CXXkv2BOgGg==
X-Received: by 2002:a05:600c:4f4d:b0:3a1:98de:abde with SMTP id m13-20020a05600c4f4d00b003a198deabdemr32990018wmq.36.1658155757918;
        Mon, 18 Jul 2022 07:49:17 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0039c5ab7167dsm19182893wmq.48.2022.07.18.07.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 07:49:17 -0700 (PDT)
Message-ID: <62d572ed.1c69fb81.c7f5e.a109@mx.google.com>
X-Google-Original-Message-ID: <YtVxx0aDa/0T6Xbz@Ansuel-xps.>
Date:   Mon, 18 Jul 2022 16:44:23 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] regmap: permit to set reg_update_bits with bulk
 implementation
References: <20220715201032.19507-1-ansuelsmth@gmail.com>
 <165815182610.53791.17547202213321860152.b4-ty@kernel.org>
 <62d564c7.1c69fb81.9010e.da70@mx.google.com>
 <YtVxPjzG2JrbPTKf@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVxPjzG2JrbPTKf@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 03:42:06PM +0100, Mark Brown wrote:
> On Mon, Jul 18, 2022 at 03:48:52PM +0200, Christian Marangi wrote:
> 
> > thanks, assuming everything went smooth with the merge to linux-next and
> > no problems arise, can you provide a signed tag?
> 
> > This is needed for a net-next series that is currently in RFC state as
> > it does depends on this.
> 
> > (I had this problem before and it was said that in this kind of
> > situation I had to ask for a signed tag to merge the related patch in
> > net-next branch)
> 
> Oh, it would have been good to know about this when reviewing the patch
> rather than after the fact - since this hadn't been mentioned it's now
> applied on the main development branch with everything that's going into
> the next release rather than on a separate branch for easy merging
> elsewhere.  How urgent is this, given that the merge window is likely to
> open at the weekend so this'll get sent to Linus at that point - is the
> driver otherwise near merging?

Ohh sorry, I was too generic in the patch comments and didn't mention it
was an actual dependency.

It's not too urgent, (I assume) but it was said that it was preferrable
to have the changes done in 2 weeks window (the one in net-next about
the working driver). Will ask on net-next and give you news ASAP.

-- 
	Ansuel
