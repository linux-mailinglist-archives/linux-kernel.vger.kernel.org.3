Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B258987B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiHDHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiHDHgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:36:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E852A964;
        Thu,  4 Aug 2022 00:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23A6ECE2591;
        Thu,  4 Aug 2022 07:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B64C433D6;
        Thu,  4 Aug 2022 07:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659598602;
        bh=ZFnofeLkIUG5GcpftrmIJLMpEZwZvl82kazSu4JuNmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Umcl8WFsYOcmUtBd5EiP4mOe/lVSrbZ+qU6+lbZrMs+V0lTnU1lb1vMMbzYq/1KHI
         mUVCo7dYoFQcRv65Z5VlVNfdjwDGuBa+OqWdqYC+X5dmcwUvewvNNaEbe4SnOLEHEM
         22HHR/J9/E1EHvYpck5VW6M9QjW/qVxMh4OJLa9YI1kYOS3soQ52BQLr7wIdL7ze6V
         i5EmE17DtlkTCEqRaWMLVg7Smq6xCfTBNrnNF66kghVZinkmU0MtalhayeQUtslJoB
         GZsH4ho+GER4zt2CNKmSmzzqtUSNspS5rUr/5APnwibs1Md4fCtFGXa+Y3PNzQIoYy
         1rmx5ry+zNcBw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJVPi-00036u-QO; Thu, 04 Aug 2022 09:37:02 +0200
Date:   Thu, 4 Aug 2022 09:37:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] Revert "dt-bindings: usb: dwc3: Add wakeup-source
 property support"
Message-ID: <Yut3Hk8akhpGlcah@hovoldconsulting.com>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-6-johan+linaro@kernel.org>
 <CAL_JsqL5ZCzfd06rxOdQodFjk4G3QpDCsxA5heM71x0q5d-hCw@mail.gmail.com>
 <YuokOn0KHEqv/CR4@hovoldconsulting.com>
 <971ad767-68b7-bbb7-f147-c3cce24fbe4f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971ad767-68b7-bbb7-f147-c3cce24fbe4f@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:51:00AM +0200, Krzysztof Kozlowski wrote:
> On 03/08/2022 09:31, Johan Hovold wrote:
> > On Tue, Aug 02, 2022 at 11:17:22AM -0600, Rob Herring wrote:
> >> On Tue, Aug 2, 2022 at 9:14 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> > 
> >>> It should also not be used to
> >>> work around Linux driver implementation issues such as how to coordinate
> >>> the glue and core dwc3 drivers.
> >>>
> >>> For the Qualcomm dwc3 controllers, it is the glue device that manages
> >>> the wakeup interrupts, which may or may not be able to wake the system
> >>> up from system suspend.
> >>
> >> While the reasoning to add this may have been for QCom, having this
> >> property for other users makes sense. On some platforms, 'snps,dwc3'
> >> is the only node (i.e. there's no wrapper node). So I don't think this
> >> should be reverted.
> > 
> > Fair enough. Let's keep it in the core child node then where we can
> > still retrieve from the glue parent directly.
> > 
> > (I assume you're not suggesting also adding 'wakeup-source' to the qcom
> > glue node, which is where the actual wakeup interrupts live.)
> > 
> > The glue and core parts needs to work in concert even if the current
> > implementation tends to make that harder than it should be.
> 
> I think it can still exist in the glue node (so your next patch),
> because as you said this is the place with wakeup interrupt, so it looks
> like correct hardware description. In the next patch you would need to
> disallow it for the DWC node.

Ok, will do. Thanks.

Johan
