Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138835740C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiGNBE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiGNBEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:04:53 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5021E3E1;
        Wed, 13 Jul 2022 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657760693; x=1689296693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OLd5uBX05p4llsvFF65oIhZFab6mXj1lRYbkOG33j1E=;
  b=IiUbc1FKq/6zjIs/IhBlz9pDmB+gJAAN3P+8MIeBvw72teUf1dHqgoid
   vtmJRdhtTwPgqRRtDOl0pm9xFOWso+CIqARjrkjN9+l+pMgazjuwQsUYd
   VMtnTSEt04RV2H1RGUz9JoHZCcaNtRk4ZIlMXUhbnt0pl3MkXA5mj+NyT
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jul 2022 18:04:52 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:04:52 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 18:04:52 -0700
Date:   Wed, 13 Jul 2022 18:04:51 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David Heidelberg" <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH 4/5] firmware: qcom: scm: Add wait-queue helper functions
Message-ID: <20220714010451.GC22183@quicinc.com>
References: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
 <1656359076-13018-5-git-send-email-quic_gurus@quicinc.com>
 <f6f26717-fb62-0700-cc2e-d6cfe3643e4b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6f26717-fb62-0700-cc2e-d6cfe3643e4b@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On Jun 28 2022 19:03, Rajendra Nayak wrote:
> 
> 
> On 6/28/2022 1:14 AM, Guru Das Srinagesh wrote:
> >When the firmware (FW) supports multiple requests per VM, and the VM also
> >supports it via the `enable-multi-call` device tree flag, the floodgates
> 
> the bindings actually define 'allow-multi-call'

Whoops, will fix in next patchset.
