Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48DB4E38C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 07:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiCVGVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 02:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiCVGVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 02:21:31 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD38BC89;
        Mon, 21 Mar 2022 23:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647930004; x=1679466004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fuupoUJoLFYUw2IJpPsW8XNa1Db+aIHi1q8einOYAIc=;
  b=EM01nKv2pI7R8tPECQuzAvuQXefDljXgAzA1vkgFXumoyfUnSkZW4hwi
   qmGpP3KHE0aUYWcGFV3sbEJW9InAI4Oms/rRC4e/+arvgnvOz4k4TvPJO
   0+CqZOl6lfqI0dYdKWp1HCI75R4jVCWqS21sqlpI+Fn0iqxfg/QAHLMEm
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Mar 2022 23:20:03 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 23:20:02 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 23:19:59 -0700
Date:   Tue, 22 Mar 2022 14:19:56 +0800
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>, <mst@redhat.com>,
        <jasowang@redhat.com>, <quic_ztu@quicinc.com>,
        <robh+dt@kernel.org>, <virtualization@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: virtio: mmio: add optional virtio,wakeup
 property
Message-ID: <20220322061956.GA1441@mingxue-gv.qualcomm.com>
References: <1646733156-19333-1-git-send-email-quic_mingxue@quicinc.com>
 <20220317063515.GA30789@mingxue-gv.qualcomm.com>
 <YjMJ32SFXTLCuaRY@myrica>
 <20220318021052.GA16300@mingxue-gv.qualcomm.com>
 <d4d69acd-72d3-dfe1-9a11-d6590d2d90d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d4d69acd-72d3-dfe1-9a11-d6590d2d90d8@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your comment. First of all, which "generic wakeup-source
property" do you mean? Could you give an example? I find "wakeup-source"
property in several binding files. Are you pointing to this? As my
understanding, there is no standard naming rule about the property of
each driver right? Currently, there's no virtio-mmio driver using this.
Anyway, I can modify my patch, if you prefer "wakeup-source".

Regards,
Minghao

On Fri, Mar 18, 2022 at 02:40:29PM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2022 03:10, Minghao Xue wrote:
> > Hi Jean and folks,
> > This is just an optional flag which could be used on an embedded system.
> > For example, if we want to use an virtio-input device as a virtual power
> > key to wake up the virtual machine, we can set this flag in the device
> > tree.
> > Currently, virio-mmio driver does not implement suspend/resume
> > callback(maybe no need). So we want to check this flag and call
> > enable_irq_wake()  accordingly in vm_find_vqs().
> 
> There is a generic wakeup-source property. How is this one different
> that you need a separate one?
> 
> 
> Best regards,
> Krzysztof
