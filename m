Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81119508062
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359373AbiDTFHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239797AbiDTFHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:07:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B07326109;
        Tue, 19 Apr 2022 22:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4035BB81CFA;
        Wed, 20 Apr 2022 05:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01483C385A1;
        Wed, 20 Apr 2022 05:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650431053;
        bh=JU6yORDTL9h+dGHWHJptPQAh/3rQDGzHsH4SL2gTeNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeJ5XndMk5w1NZPnXNkNHOHf0jJDmiBmCOgFvGoxqH2mYfUJY1pBDawwluwcWLiey
         XF+aF0fYnQ6qttx/C21DgC2XkqiyK9Jpl3aKskDZjVx9vw93FMSG6X8dWZqRyoaMqi
         7kCT2urvTMsxwx7dh7lQTHefcZyaUaWtjGbLBpmUxqtW0RPrqK5VTvtt6KBgr8Nmn/
         hV6VPRDR8n7jWk7+/7okxQENeJo46wSNMQMfdOHMW7ymW02Gt6Q+c03qLH2XcWIlCr
         YoPSBTnmkihFnrX5jQ2zQFjycImxyMpEidEIqAq30Ho0JmCCjpMYTF2UZOXgVO8uA3
         zQMRU5Yk4NJWg==
Date:   Wed, 20 Apr 2022 10:34:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Cc:     sboyd@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        david@ixit.cz, devicetree@vger.kernel.org, lee.jones@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, ~okias/devicetree@lists.sr.ht
Subject: Re: [PATCH v3] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to
 yaml
Message-ID: <Yl+UScVRfO0USVlk@matsya>
References: <YfjJOQIuGJvedFmJ@matsya>
 <1650408175-12973-1-git-send-email-quic_subbaram@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650408175-12973-1-git-send-email-quic_subbaram@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-22, 15:42, Subbaraman Narayanamurthy wrote:
> >> Convert Qualcomm PMIC SPMI binding to yaml format.
> 
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> 
> > Steve, Can this be picked up please. I will rebase my v7 update based on
> > this...
> 
> Can this DT bindings conversion patch be picked up please?
Yes please

This and spmi v7 support patches have been on list for quite long...

Thanks
-- 
~Vinod
