Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06E352D747
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbiESPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbiESPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:19:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD564EBEA0;
        Thu, 19 May 2022 08:19:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 921B515A1;
        Thu, 19 May 2022 08:19:13 -0700 (PDT)
Received: from bogus (unknown [10.57.66.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 600FB3F66F;
        Thu, 19 May 2022 08:19:10 -0700 (PDT)
Date:   Thu, 19 May 2022 16:19:03 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] mailbox: correct kerneldoc
Message-ID: <20220519151903.hvqyrw3yib2mb6yg@bogus>
References: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
 <20220519151334.64t5zsudz7dd35im@bogus>
 <92a21768-204d-fc68-8942-99e2bc3df4cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a21768-204d-fc68-8942-99e2bc3df4cf@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 05:14:33PM +0200, Krzysztof Kozlowski wrote:
> On 19/05/2022 17:13, Sudeep Holla wrote:
> > On Sun, May 01, 2022 at 12:34:27PM +0200, Krzysztof Kozlowski wrote:
> >> Correct kerneldoc warnings like:
> >>
> >>   drivers/mailbox/arm_mhu_db.c:47:
> >>     warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> >>   drivers/mailbox/qcom-ipcc.c:58:
> >>     warning: Function parameter or member 'num_chans' not described in 'qcom_ipcc'
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  drivers/mailbox/arm_mhu_db.c | 2 +-
> > 
> > I thought I had copied it from arm_mhuc.c but apparently not. Anyways,
> > 
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> 
> 
> Thanks! Could someone pick these two patches?
> 

They generally go via Jassi's tree.

Hi Jassi,

There is another PCC driver fix that I had acked few weeks back. Please
pick this as well as that when you start finalising patches for your PR
for v5.19.

-- 
Regards,
Sudeep
