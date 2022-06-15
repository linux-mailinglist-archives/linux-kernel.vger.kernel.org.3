Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB49F54D3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbiFOVcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347869AbiFOVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:32:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0167A562F0;
        Wed, 15 Jun 2022 14:32:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o16so17006443wra.4;
        Wed, 15 Jun 2022 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=QopEfhTkFlF6asUqaeewrIqz9LEOWIA0DIGY0C56DCA=;
        b=NHVyVE06MIrOuTx88mvD/5kFBj4tSiOZIt3qtlKYy9iWIRYmJdctsXy0XbIYXcEpKY
         /am8V/tQO3aKJWF0s26guj2RzFwKQixfXcxPr8LVMHGwfZDFaSrJdwnGLROTb+lwjIAx
         YLwSHnQGlau80zz+OtIahw3vBwTCNUKzR4ic51PkMKUhhgPY9ZYGJu3qIggam92ErT0b
         grWKbkiB44I8P2Mu7HUH5UwuJZnByT3AaCpnjHeKaa/sRKLxY97yzZOH5GGB53T1eR8z
         oflE5XKAbk2VlORfVNH5xIcmTsyVfnceGs1KcS3nfzFHn+7oArFIFzZa3nHo0j5tQb8v
         EH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=QopEfhTkFlF6asUqaeewrIqz9LEOWIA0DIGY0C56DCA=;
        b=vvLDYBiB5jwSxq5ZjPaC4jrINIVwSerpvq5ufZ7imYmWIcdnLGlHf+AJskzbEvVQcN
         l1uVq1sQa/+GXPfHC6Q8SsHJNDv+3PSgUkm9Rb4My+FfMbfaeOQr1juk7QvKV6NlzRCp
         l7+tvLGZTH1ed8vjgzbHtiInjuNAFSPTW1A8lZQm07M1wSdGSs8usa+rP1SIXuQLqLmm
         p/h7ffF3gtR5aZEl+VHZjSXHd9j0KcLl3WRnOQpC8yJBvOl3xbtFZT6YB1G5LpsOMVny
         XHEKVNHcK/SU05poI+OUbMa4QWI16ld3o8p9hS1G3UP9FFLpn04q1Ew5DnAZ5y4WRh6Y
         LJLw==
X-Gm-Message-State: AJIora+4rfAcGpRSigaFvZ7lKBvB9081XpO83a1b493MFbARFqYaErzc
        BxnES++6vxVSsKH3wt5SRYhaNPZps64=
X-Google-Smtp-Source: AGRyM1uYQR07hPtOK9I7b/8Q5GHYy1IwlK8jeKJC6zVVl4Tov0DYRWCl6mrkG+oodNfVhHKN1usclQ==
X-Received: by 2002:a05:6000:1ac8:b0:218:64a2:9d00 with SMTP id i8-20020a0560001ac800b0021864a29d00mr1724239wry.272.1655328722163;
        Wed, 15 Jun 2022 14:32:02 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id b3-20020adfe643000000b0020e6c51f070sm12931wrn.112.2022.06.15.14.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:32:01 -0700 (PDT)
Message-ID: <62aa4fd1.1c69fb81.8e536.0056@mx.google.com>
X-Google-Original-Message-ID: <YqpP4bxiByTCxC9E@Ansuel-xps.>
Date:   Wed, 15 Jun 2022 23:32:17 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
References: <20220615163408.30154-1-ansuelsmth@gmail.com>
 <a92fe431-a995-4c7f-b90b-8e80298bc71a@linaro.org>
 <62aa1b41.1c69fb81.95632.5b71@mx.google.com>
 <717ad899-31ad-5e70-b299-ffb8ca287071@linaro.org>
 <62aa1dd0.1c69fb81.b9887.676e@mx.google.com>
 <044dacdb-7d11-8c68-3fb7-ebd67621225e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044dacdb-7d11-8c68-3fb7-ebd67621225e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:53:44PM -0700, Krzysztof Kozlowski wrote:
> On 15/06/2022 10:04, Ansuel Smith wrote:
> > On Wed, Jun 15, 2022 at 10:50:17AM -0700, Krzysztof Kozlowski wrote:
> >> On 15/06/2022 09:53, Ansuel Smith wrote:
> >>> On Wed, Jun 15, 2022 at 10:43:10AM -0700, Krzysztof Kozlowski wrote:
> >>>> On 15/06/2022 09:34, Christian 'Ansuel' Marangi wrote:
> >>>>> Add pcm reset define for ipq806x lcc.
> >>>>>
> >>>>> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> >>>> To prevent any confusion about identities (we have strict rules about
> >>>> these), I need to ask - who uses this email address?
> >>>>
> >>>> https://lore.kernel.org/all/?q=ansuelsmth%40gmail.com
> >>>>
> >>>> Best regards,
> >>>> Krzysztof
> >>>
> >>> Same person. Started using extended name, wanted to do this change from
> >>> a long time but all the patch were already pushed so I couldn't change
> >>> it since they were already proposed and on the various mailing list.
> >>
> >> Previously "Ansuel Smith" was used entirely, without any parts of this
> >> name. Here 'Ansuel' appears in quotes, which usually is used for nicknames.
> >>
> >> Is "Ansuel Smith" your real name or a nickname? What do you mean by
> >> "extended name"?
> >>
> > 
> > Ansuel is second name. Smith is not real... (sorry)
> > So with extendend name I mean full name + second name that is
> > Christian Ansuel Marangi.
> > 
> > Honestly it's a very stupid mistake by me not using the full name from
> > the start.
> 
> Not-real names are no accepted [1] and since we cannot validate this, we
> trust. Quite a lot in our process depends on trust. Once trust is gone,
> it's not easy to get it back... Worth watching - Trust and the Linux
> development model; Greg KH [2].
> 
> Anyway I have no clue which identity to trust...
>

Again it's the same person, just a change in the name but I see your
point. As suggested in the other patch I will just change to Christian
Marangi sadly if necessary, hoping I regain trust in the future.

Just as an info, as I pushed also other patch and some are with various
revision, how to handle the Sob? Change it and put an alert in the
version changelog or should I keep the old one?

Again sorry for the mess but it had to be done, didn't think it caused
that much problems :(

> 
> [1]
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=certificate#sign-your-work-the-developer-s-certificate-of-origin
> 
> [2] https://www.youtube.com/watch?v=nhJqaZT94z0&t=7044s&ab_channel=hupstream
> 
> Best regards,
> Krzysztof

(if the concern is with understanding if I'm not stealing the identity
of someone else, there must be a way to prove that, on github I sign
every commit with the PGP key and I updated the name also there.)

-- 
	Ansuel
