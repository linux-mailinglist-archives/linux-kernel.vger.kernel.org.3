Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C737950DBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiDYJB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiDYJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:01:54 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391B513DCE;
        Mon, 25 Apr 2022 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650877131; x=1682413131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/LMMZBwH6tN0t1Z2BqS7eB4GESXopgySii1X8NSdGyk=;
  b=b7IWoB4kBBhkk9jD6uJZ3sb9228iQx4NjF8BOLHgffkxcH/8+ZsTIbJr
   YhtipDj06g0rwjx93Uu03P5rv96Mr++Wp+qFODAqcv6rFsaTypgg0OkO7
   ys4bQ/puZh6OnX5OEuBfBFSxjIH5wVniJLKMlePg/Pp4uzTZt7acxyR03
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Apr 2022 01:58:50 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 01:58:50 -0700
Received: from mingxue-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 01:58:48 -0700
Date:   Mon, 25 Apr 2022 16:58:44 +0800
From:   Minghao Xue <quic_mingxue@quicinc.com>
To:     <mst@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>, <jasowang@redhat.com>,
        <robh+dt@kernel.org>, <jean-philippe@linaro.org>,
        <virtualization@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ztu@quicinc.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional
 wakeup-source property
Message-ID: <20220425085844.GA7652@mingxue-gv.qualcomm.com>
References: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
 <20220328164228-mutt-send-email-mst@kernel.org>
 <20220329074610.GA20342@mingxue-gv.qualcomm.com>
 <a35529be-d9cb-9913-76aa-653faed87b54@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a35529be-d9cb-9913-76aa-653faed87b54@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:59:31AM +0200, Krzysztof Kozlowski wrote:
> On 29/03/2022 09:46, Minghao Xue wrote:
> > On Mon, Mar 28, 2022 at 04:42:59PM -0400, Michael S. Tsirkin wrote:
> >> On Fri, Mar 25, 2022 at 09:59:45AM +0800, Minghao Xue wrote:
> >>> Some systems want to set the interrupt of virtio_mmio device
> >>> as a wakeup source. On such systems, we'll use the existence
> >>> of the "wakeup-source" property as a signal of requirement.
> >>>
> >>> Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
> >>
> >> I don't have enough of a clue about dt to review this.
> >> Pls get some acks from people with DT expertise.
> >>
> > Hi Michael,
> > I had a discussion with Krzysztof on the first version of patch. And we've
> > got aligned. 
> > 
> 
> I thought I reviewed this and provided an ack, but apparently I did not.
> Sorry for late response.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
Hi Michael,
I'm writting email to ask will you help upstream these two patches? And
how's the progress?

Thanks,
Minghao
