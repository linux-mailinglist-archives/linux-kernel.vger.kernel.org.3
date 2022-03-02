Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5F4CAC5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbiCBRqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiCBRp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:45:59 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0AFD04AC;
        Wed,  2 Mar 2022 09:45:16 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id a6so2389001oid.9;
        Wed, 02 Mar 2022 09:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yBVdzuiyU1WGRmz0k+7K6FagVTaPofIWMdkiSD45gb0=;
        b=S3RpspGoPN4IvzYzmfLq0BRMYDYl3YP5p76HuJYX6FLvH78X9/shsPd7F/0tyoOqbE
         clbsbj5XEd8kuY0wcWEWq52lwETUJ809Hkxemg+PmoVFV+qANZ9MAJVXmwiQ3jdzDpra
         ZKqsMDZCg9NR27adKki9dNWjgtBqeL5reoIxRA3uoPDOX/VJrSQKIb3Vjjd44etPyfL3
         MaHQe++8Aqy4eUhoJY0OsoTxLJKz7iCDRctpWU2P7Hxvoog5l2q9NQ6RG1q1q4eVK67m
         rVzl9SP6/AJQtkO2EE5E8MFDxm9OH1Eh4VYkFf7q6DvQXdKP6CdQ6NjtnOb6LoJdF0nD
         C+IQ==
X-Gm-Message-State: AOAM532n1s7SiHFv1+Oc8/RTtJl8u4m7XEp33a5pZG6Ud9dV0Z/fmzsP
        5943qpTBkDBHmhd77LcbHg==
X-Google-Smtp-Source: ABdhPJxeZz6rMGJAS9pOd1GH0e5BV1U1NS5hMfeK9uT22Sl8Nq99AVCUSNddmrw6fqe70dvRRqt0ww==
X-Received: by 2002:a05:6808:130a:b0:2d7:1928:65a0 with SMTP id y10-20020a056808130a00b002d7192865a0mr852987oiv.35.1646243115390;
        Wed, 02 Mar 2022 09:45:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r18-20020a056830081200b005ad10dfcf60sm8034646ots.67.2022.03.02.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:45:14 -0800 (PST)
Received: (nullmailer pid 3945731 invoked by uid 1000);
        Wed, 02 Mar 2022 17:45:13 -0000
Date:   Wed, 2 Mar 2022 11:45:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: opp: Add "opp-microwatt" entry in
 the OPP
Message-ID: <Yh+tKe7oWCpmj5MC@robh.at.kernel.org>
References: <20220302112917.27270-1-lukasz.luba@arm.com>
 <20220302112917.27270-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302112917.27270-2-lukasz.luba@arm.com>
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

On Wed, Mar 02, 2022 at 11:29:13AM +0000, Lukasz Luba wrote:
> Add new entry for the OPP which provides information about power
> expressed in micro-Watts. It is useful for the Energy Model framework.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  .../devicetree/bindings/opp/opp-v2-base.yaml  | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
