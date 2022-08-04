Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5114658A063
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiHDSSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbiHDSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:18:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851596C10F;
        Thu,  4 Aug 2022 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=HQnDE9KIeWemmb+tzvRoACUA8toA0VRugtuXG98IQQA=; b=jt+MHWhb+KTJ3mdxJg83/7IsE1
        pezvP6aPwRj1fkpivTw+VGX3q/Ktpi5QyApN1avBq+TqQa2aOtON7SPbLveReX5NXqOp1yWw+KTkX
        8IfVA6I4IIO5yfjOoSbrV9NBGKJZ1lIoGr2DsQAwWEhGC7UhgXEbNxV/i1wsYbVCjMR02Q5JuCPvX
        gsIXAv/ucfp/ku2XKyXgpiVPslpWjEHaMsu8CNP+0X/Dy8Q/vul7eIHtFm/lxpRJ/yVC8InrNFvZc
        cU0UzJSWtXlrCV/6IgXDIXiHdvKg/OG+m3zFQYHh+kKzH5mKV/Fr/QputL/809lAZqtTb3qb/iEee
        g6p4F84w==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oJfQY-0089Df-Qk; Thu, 04 Aug 2022 18:18:34 +0000
Message-ID: <ad1dbcdd-64c8-1243-8629-275cea4099b6@infradead.org>
Date:   Thu, 4 Aug 2022 11:18:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/9] usb: dwc3: qcom: fix gadget-only builds
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-4-johan+linaro@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220804151001.23612-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 8/4/22 08:09, Johan Hovold wrote:
> A recent change added a dependency to the USB host stack and broke
> gadget-only builds of the driver.
> 
> Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> 
> Changes in v2
>  - new patch
> 
>  drivers/usb/dwc3/dwc3-qcom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index be2e3dd36440..e9364141661b 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -310,8 +310,11 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
>  	 * currently supports only 1 port per controller. So
>  	 * this is sufficient.
>  	 */
> +#ifdef CONFIG_USB
>  	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> -
> +#else
> +	udev = NULL;
> +#endif
>  	if (!udev)
>  		return USB_SPEED_UNKNOWN;
>  

-- 
~Randy
