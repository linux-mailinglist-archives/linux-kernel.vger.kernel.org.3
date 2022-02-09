Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89874AE78A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiBIDIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352784AbiBIDHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:07:19 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181EEC061355;
        Tue,  8 Feb 2022 19:07:19 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id s185so1195804oie.3;
        Tue, 08 Feb 2022 19:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zK4mNlft0YSBrS1EUUtnZ1eiCxH6p/RVKxlEycE1ok=;
        b=zV+UL1/rq+QB5T/bBSZz/acLjAkQWz86ys0sPEk5LPlA6KCUA7lGxzcVJZqfCoLh2i
         r6b1RDOe5UOn2wTodFJeOp2TkGACi5bHKuw0BPHldY846Xq/TWLGjaepGLTXI/Jf7CXh
         9CAb/olwD9XUTCPFhSJeuDxy19BJSA67E7R73CR6Axr6nPqtizPAqtSncVk89UgKxHka
         DJCWayy3uHuSVF/HqSj2YZ2afmwHODXJ5UJqtTv3uhqWRVn3qUVDWHeEhPt9E0QY3+fD
         eoeEuGHCBdVscU+g1ijTbB9AFtjd4I72hKvujPVRnYeMkmRlL1ZBonRU0J26M3W+gM6n
         Zz7A==
X-Gm-Message-State: AOAM530stBboYCnt5M6TJv/p9e8sDzSbuH3hbJckNvLf8JvvIO8F7OIO
        lNDdkBRpJKBmevGPhW8+KA==
X-Google-Smtp-Source: ABdhPJxVQa/OMB3jeFEviv/+OHHc5hTS47P1H6zGuk+DV0L87x8EQ3rVWsVnMJo7VRW3gI2yQeavOg==
X-Received: by 2002:a05:6808:158b:: with SMTP id t11mr435650oiw.250.1644376038421;
        Tue, 08 Feb 2022 19:07:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g34sm6140107ooi.48.2022.02.08.19.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:07:17 -0800 (PST)
Received: (nullmailer pid 3547540 invoked by uid 1000);
        Wed, 09 Feb 2022 03:07:16 -0000
Date:   Tue, 8 Feb 2022 21:07:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Tony Luck <tony.luck@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-arm-msm@vger.kernel.org, Colin Cross <ccross@android.com>,
        linux-input@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Martinz <amartinz@shiftphones.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        dri-devel@lists.freedesktop.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: vendor-prefixes: add vendor prefix for
 SHIFT
Message-ID: <YgMv5A7gwz9a8VNK@robh.at.kernel.org>
References: <20220123173650.290349-6-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123173650.290349-6-caleb@connolly.tech>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 17:38:08 +0000, Caleb Connolly wrote:
> Add SHIFT vendor prefix, SHIFT make various devices such as the SHIF6mq
> phone.
> 
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
