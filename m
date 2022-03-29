Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA20F4EA8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiC2HsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiC2Hr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:47:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479D1C391E;
        Tue, 29 Mar 2022 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648539976; x=1680075976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iv6eZyi8BlLuO8dorNPKusST5FRIAaRdbW31rrkLVqQ=;
  b=TjsIx33f2xk8A92Y4tAPJG7akur8lRbSPGNt48DPFv/bHHHghB3nbkV2
   hKV9x1Qaqy/sqXSHyBkd+in8yTWtxWU0R0w44Y8JTuSF2Fd2mAdGTWCMk
   ZDHPLHyanVjrypWyDQ2DyNV7FUFdoRZSzMa+PgzSKmWTxFCkR3uSWLJ5Q
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Mar 2022 00:46:16 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 00:46:16 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 00:46:14 -0700
Date:   Tue, 29 Mar 2022 15:46:11 +0800
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <robh+dt@kernel.org>,
        <jean-philippe@linaro.org>,
        <virtualization@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ztu@quicinc.com>, <krzk@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional
 wakeup-source property
Message-ID: <20220329074610.GA20342@mingxue-gv.qualcomm.com>
References: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
 <20220328164228-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220328164228-mutt-send-email-mst@kernel.org>
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

On Mon, Mar 28, 2022 at 04:42:59PM -0400, Michael S. Tsirkin wrote:
> On Fri, Mar 25, 2022 at 09:59:45AM +0800, Minghao Xue wrote:
> > Some systems want to set the interrupt of virtio_mmio device
> > as a wakeup source. On such systems, we'll use the existence
> > of the "wakeup-source" property as a signal of requirement.
> > 
> > Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
> 
> I don't have enough of a clue about dt to review this.
> Pls get some acks from people with DT expertise.
> 
Hi Michael,
I had a discussion with Krzysztof on the first version of patch. And we've
got aligned. 

Regards,
Minghao

> > ---
> > v1 -> v2: rename property from "virtio,wakeup" to "wakeup-source"
> > 
> >  Documentation/devicetree/bindings/virtio/mmio.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> > index 4b7a027..160b21b 100644
> > --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> > +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> > @@ -31,6 +31,10 @@ properties:
> >      description: Required for devices making accesses thru an IOMMU.
> >      maxItems: 1
> >  
> > +  wakeup-source:
> > +    type: boolean
> > +    description: Required for setting irq of a virtio_mmio device as wakeup source.
> > +
> >  required:
> >    - compatible
> >    - reg
> > -- 
> > 2.7.4
> 
