Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C455A5F1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 03:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiFYB5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 21:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFYB5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 21:57:17 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414D51E52;
        Fri, 24 Jun 2022 18:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656122236; x=1687658236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9SWAe/gPW+o7A+E1CI50enYZzx1mTK47iGojpYjytnY=;
  b=t+liYEIzwGFFHJzGQxuTNgE4CzrwRN9vMkoftEGrvrGBR96DdhIGs7pf
   HakHBtg0H0x5KKOOBbnwzwN5D+X5z9J0dMgVkIQ0v7m5iLGOvZ7MNz76K
   VgIYwEabEZnKXVFHZyp3XvD7FxQ21pMQRc0sp+96hbmThx03CfaDU27LU
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jun 2022 18:57:16 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 18:57:15 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 24 Jun
 2022 18:57:15 -0700
Date:   Fri, 24 Jun 2022 18:57:14 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Robert Marko <robimarko@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: firmware: qcom-scm: convert to dtschema
Message-ID: <20220625015714.GA6675@quicinc.com>
References: <20220623182542.1116677-1-robimarko@gmail.com>
 <20220624010103.GA23758@quicinc.com>
 <CAOX2RU7yKuV4i_9YRs9fx2DTTvAndWFFw3cYtQ3qFk9m1zZJVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOX2RU7yKuV4i_9YRs9fx2DTTvAndWFFw3cYtQ3qFk9m1zZJVg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 24 2022 10:50, Robert Marko wrote:
> On Fri, 24 Jun 2022 at 03:01, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
> >
> > On Thu, Jun 23, 2022 at 08:25:42PM +0200, Robert Marko wrote:
> >
> > > +
> > > +description: |
> > ...
> > > +
> > > +  '#reset-cells':
> > > +    const: 1
> >
> > This isn't part of the original file - could you please explain why this is
> > being added?
> 
> Yes, its not part of the original file, however I noticed that a lot of SCM
> nodes were adding #reset-cells, and upon looking at the SCM code its
> clear that it is being registered as a reset controller so #reset-cells are
> appropriate.
> 
> However, since its not really being used via phandles #reset-cells did
> not really matter, hence why I did not add them to be required,
> this is something that DT guys can probably clarify.

Makes sense, ACK.

Thank you.

Guru Das.
