Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1D578C05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiGRUrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiGRUq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:46:58 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA0A30F58;
        Mon, 18 Jul 2022 13:46:54 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id w9so3162146ilg.1;
        Mon, 18 Jul 2022 13:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nsrM3GN1ydAPWBx+VmK+tAx9zDddS8+cskMqenrufDM=;
        b=GUpbDkukWeUh0gi9gpp4DZ27HOJ1x6R2wadJ96f/uBueb6T9rq5Cv7RGYNtmDNyk3w
         /8W3bm4oaWTQSMYd8/4dtcgWK2AjV02BchGdHlUxDYK/ECt0j88HBnXHXzRWaWEHOAES
         iL91RwJu/fRySH2QWhc2E2WLBxJey2dB10CPt6HK4PDAQvIkM718ATn2JWdrQ5YD1FKR
         pu4x8zyaV2MI+UbXn20Vjb/EUAzIR2Ejde/yX/7azwMT068IT50ZZW4iB+Fuo9HkqfK8
         C/zjX0rOyE4q3tPq9JfT9v/RflSlb6yv8WSjF9XnA79Q2w29g0rrWWpsXLQ9SrhNVqo5
         HkQg==
X-Gm-Message-State: AJIora+TDAXLkmxKEuN7h+nkNzVEaoYOW65ZfbjAslhXiM3xqR1sL35l
        GLOg30R1Olta+qtjR2fdRg==
X-Google-Smtp-Source: AGRyM1sZBw1swY7XFZ3jNeHehuSXsWVnT5WjqKZCO9YVkFSU78+mGn1KYtm41y69GdS5z/ch9rmqCA==
X-Received: by 2002:a05:6e02:102:b0:2dc:8fa:5f9d with SMTP id t2-20020a056e02010200b002dc08fa5f9dmr14637160ilm.231.1658177214050;
        Mon, 18 Jul 2022 13:46:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id ch23-20020a0566383e9700b003415f2fb081sm3047498jab.125.2022.07.18.13.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:46:53 -0700 (PDT)
Received: (nullmailer pid 3523017 invoked by uid 1000);
        Mon, 18 Jul 2022 20:46:51 -0000
Date:   Mon, 18 Jul 2022 14:46:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] dt-bindings: cpufreq-qcom-hw: Move clocks to CPU
 nodes
Message-ID: <20220718204651.GA3505083-robh@kernel.org>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
 <035fe13689dad6d3867a1d33f7d5e91d4637d14a.1657695140.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <035fe13689dad6d3867a1d33f7d5e91d4637d14a.1657695140.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:22:56PM +0530, Viresh Kumar wrote:
> cpufreq-hw is a hardware engine, which takes care of frequency
> management for CPUs. The engine manages the clocks for CPU devices, but
> it isn't the end consumer of the clocks, which are the CPUs in this
> case.

The question is really where does the clock mux live?

> For this reason, it looks incorrect to keep the clock related properties
> in the cpufreq-hw node. They should really be present at the end user,
> i.e. the CPUs.

The issue is that the CPU itself probably only has 1 clock input (at 
least for its core frequency). Listing out all possible clock sources in 
CPU node 'clocks' is wrong too.

> The case was simple currently as all the devices, i.e. the CPUs, that
> the engine manages share the same clock names. What if the clock names
> are different for different CPUs or clusters ? How will keeping the
> clock properties in the cpufreq-hw node work in that case ?
> 
> This design creates further problems for frameworks like OPP, which
> expects all such details (clocks) to be present in the end device node
> itself, instead of another related node.
> 
> Move the clocks properties to the node that uses them instead.

What's the purpose of freq-domain binding now? I thought the idea was to 
use that instead of clocks directly.

Rob
