Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94258BA7C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiHGJt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiHGJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 05:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA43B869;
        Sun,  7 Aug 2022 02:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F9A60E2C;
        Sun,  7 Aug 2022 09:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5667C433D6;
        Sun,  7 Aug 2022 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659865791;
        bh=TNFwdYXJjP8nzLizUc8hS+Xwx4sjB4RVvp6eTa7E2JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvW2vSXHKOytlYPj19On6aicF/MDYb2+szAiJbdg8H0Mm6HpUjml4Y7/JzcKqw8hm
         2YTOO3MFDXGmgpYMiRcVE3+3W25dbKmbSi7N7S0PYC0Zhkft2+LmIl911jqu5dnUN8
         kCTGzmUI15ZuRAV+9g7Md9NUZE0a2YNIS+Ou4Js9xauCsuflbPEfQ5/4Yr+CP4qE2B
         DTqjyn/PgeK2Je2I8r3WZ8Z4arASEywAvDKim+GxVwTF8F6CUXqWGWE2BIVp0h1v6q
         FEKtb/5PznrfsKObZz2cylt1KnTwILX07SXXO7Z7Y9H9A7pWv+Ftc5W9L1LVHWzaTh
         JyCio74k+Ft5g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oKcvL-00068u-NB; Sun, 07 Aug 2022 11:50:20 +0200
Date:   Sun, 7 Aug 2022 11:50:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: dwc3: qcom: clean up icc init
Message-ID: <Yu+K28R2YJ327jET@hovoldconsulting.com>
References: <20220805074500.21469-1-johan+linaro@kernel.org>
 <20220805074500.21469-3-johan+linaro@kernel.org>
 <Yu1Y1nDCyzKhJUAI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu1Y1nDCyzKhJUAI@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 10:52:22AM -0700, Matthias Kaehlcke wrote:
> On Fri, Aug 05, 2022 at 09:45:00AM +0200, Johan Hovold wrote:
> > Clean up the interconnect-initialisation helper by increasing
> > indentation of (or merging) continuation lines and adding brackets
> > around multi-line blocks in order to improve readability.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/usb/dwc3/dwc3-qcom.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > index 196efa9f2545..f2ff4fe1490a 100644
> > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > @@ -253,7 +253,7 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
> >  	qcom->icc_path_ddr = of_icc_get(dev, "usb-ddr");
> >  	if (IS_ERR(qcom->icc_path_ddr)) {
> >  		dev_err(dev, "failed to get usb-ddr path: %ld\n",
> > -			PTR_ERR(qcom->icc_path_ddr));
> > +				PTR_ERR(qcom->icc_path_ddr));
> 
> What's wrong with the existing indentation? It looks similar to the indentation
> changes you do below for icc_set_bw().

The indentation of continuation lines in this driver is a bit
inconsistent, but the above change matches the next conditional and the
rest of the function (which does not use open-parenthesis alignment).

> Maybe your preference is double indentation for continuation lines rather than
> aligning them roughly with the opening parenthesis of the calling function?

I generally prefer two tabs over excessive indentation involving space
characters that need to be added or removed in continuation lines just
because a symbol name is updated.

> >  		return PTR_ERR(qcom->icc_path_ddr);
> >  	}
> >  
> > @@ -265,20 +265,19 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
> >  	}
> >  
> >  	max_speed = usb_get_maximum_speed(&qcom->dwc3->dev);
> > -	if (max_speed >= USB_SPEED_SUPER || max_speed == USB_SPEED_UNKNOWN)
> > +	if (max_speed >= USB_SPEED_SUPER || max_speed == USB_SPEED_UNKNOWN) {
> >  		ret = icc_set_bw(qcom->icc_path_ddr,
> > -			USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
> > -	else
> > +				USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
> > +	} else {
> >  		ret = icc_set_bw(qcom->icc_path_ddr,
> > -			USB_MEMORY_AVG_HS_BW, USB_MEMORY_PEAK_HS_BW);
> > -
> > +				USB_MEMORY_AVG_HS_BW, USB_MEMORY_PEAK_HS_BW);
> > +	}
> >  	if (ret) {
> >  		dev_err(dev, "failed to set bandwidth for usb-ddr path: %d\n", ret);
> >  		return ret;
> >  	}
> >  
> > -	ret = icc_set_bw(qcom->icc_path_apps,
> > -		APPS_USB_AVG_BW, APPS_USB_PEAK_BW);
> > +	ret = icc_set_bw(qcom->icc_path_apps, APPS_USB_AVG_BW, APPS_USB_PEAK_BW);
> >  	if (ret) {
> >  		dev_err(dev, "failed to set bandwidth for apps-usb path: %d\n", ret);
> >  		return ret;

Johan
