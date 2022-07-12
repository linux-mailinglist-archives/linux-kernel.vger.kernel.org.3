Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4FF570F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiGLBUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGLBT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1A5245F;
        Mon, 11 Jul 2022 18:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E57D86163F;
        Tue, 12 Jul 2022 01:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA6FC341C8;
        Tue, 12 Jul 2022 01:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657588794;
        bh=Ix2ta+DW8dj5jT8OH9n1J2Kk3GuzFkbKY8qR6aMYzSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFlF58+en7nYWs9++XeO5XxD6F28FpyVqWihHBelFAIxHxNygnTDV8uUoOR4JOuBf
         UTuNeSrdljh/8TpABt5FjTKF237KyeVtIhNSv7qz1cUk2hGq6e06etBABf6Qo8mZ0N
         j/xAI2RIOsdURIDcRReue7bWiEnwbjMbwotvgLgvogiHcAxjogRvjK/UkqWfhdX7Ul
         9/3LSnA/UuAo1QrLTlgil4ZOsqQGIG5sewYDk3CUhKITOWx1wRAqynyQilYbi7zb3l
         4DTS0fjdocdqrcOqKbiTFScM3QnX+eSSrxBAQYtj7/W033VHzC+Y6Yig3ExGy/kbGX
         yH72HEWrOUGPw==
Date:   Tue, 12 Jul 2022 09:19:48 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     "Mehta, Piyush" <piyush.mehta@amd.com>
Cc:     Piyush Mehta <piyush.mehta@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>,
        "sivadur@xilinx.com" <sivadur@xilinx.com>,
        "radheys@xilinx.com" <radheys@xilinx.com>
Subject: Re: [RFC PATCH] usb: chipidea: Add support for VBUS control with PHY
Message-ID: <20220712011948.GA210054@nchen-desktop>
References: <20220524120802.9394-1-piyush.mehta@xilinx.com>
 <20220703003434.GA1382015@Peter>
 <MN2PR12MB4333A5DB77BC767A01A7AA2688879@MN2PR12MB4333.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4333A5DB77BC767A01A7AA2688879@MN2PR12MB4333.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-11 16:45:20, Mehta, Piyush wrote:
> Hello Peter,
> 
> Thanks for the review.
> Yes, we are supporting OTG feature and have used OTG FSM platform.

Please generate the formal patch with my ack, thanks.

Acked-by: Peter Chen <peter.chen@kernel.org>

> 
> Regards,
> Piyush Mehta 
> 
> > -----Original Message-----
> > From: Peter Chen <peter.chen@kernel.org>
> > Sent: Sunday, July 3, 2022 6:05 AM
> > To: Piyush Mehta <piyush.mehta@xilinx.com>
> > Cc: gregkh@linuxfoundation.org; michal.simek@xilinx.com; linux-
> > usb@vger.kernel.org; linux-kernel@vger.kernel.org; git@xilinx.com;
> > sivadur@xilinx.com; radheys@xilinx.com
> > Subject: Re: [RFC PATCH] usb: chipidea: Add support for VBUS control with
> > PHY
> > 
> > CAUTION: This message has originated from an External Source. Please use
> > proper judgment and caution when opening attachments, clicking links, or
> > responding to this email.
> > 
> > 
> > On 22-05-24 17:38:02, Piyush Mehta wrote:
> > > Some platforms make use of VBUS control over PHY which means
> > > controller driver has to access PHY registers to turn on/off VBUS
> > > line.This patch adds support for such platforms in chipidea.
> > >
> > > Flag 'CI_HDRC_PHY_VBUS_CONTROL' added to support VBus control
> > feature.
> > >
> > > Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> > > ---
> > > We have created this patch as RFC, as I introduced a new flag
> > > (CI_HDRC_PHY_VBUS_CONTROL) and would like to get comment if it's the
> > > proper way to check for VBus support for zynq.
> > > ---
> > >  drivers/usb/chipidea/ci_hdrc_usb2.c | 1 +
> > >  drivers/usb/chipidea/host.c         | 7 +++++++
> > >  drivers/usb/chipidea/otg_fsm.c      | 7 +++++++
> > >  include/linux/usb/chipidea.h        | 1 +
> > >  4 files changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c
> > > b/drivers/usb/chipidea/ci_hdrc_usb2.c
> > > index 89e1d82..dc86b12 100644
> > > --- a/drivers/usb/chipidea/ci_hdrc_usb2.c
> > > +++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
> > > @@ -30,6 +30,7 @@ static const struct ci_hdrc_platform_data
> > > ci_default_pdata = {
> > >
> > >  static const struct ci_hdrc_platform_data ci_zynq_pdata = {
> > >       .capoffset      = DEF_CAPOFFSET,
> > > +     .flags          = CI_HDRC_PHY_VBUS_CONTROL,
> > >  };
> > >
> > >  static const struct ci_hdrc_platform_data ci_zevio_pdata = { diff
> > > --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > > index bdc3885..bc3634a 100644
> > > --- a/drivers/usb/chipidea/host.c
> > > +++ b/drivers/usb/chipidea/host.c
> > > @@ -63,6 +63,13 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int
> > portnum, bool enable)
> > >               priv->enabled = enable;
> > >       }
> > >
> > > +     if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL) {
> > > +             if (enable)
> > > +                     usb_phy_vbus_on(ci->usb_phy);
> > > +             else
> > > +                     usb_phy_vbus_off(ci->usb_phy);
> > > +     }
> > > +
> > >       if (enable && (ci->platdata->phy_mode ==
> > USBPHY_INTERFACE_MODE_HSIC)) {
> > >               /*
> > >                * Marvell 28nm HSIC PHY requires forcing the port to HS mode.
> > > diff --git a/drivers/usb/chipidea/otg_fsm.c
> > > b/drivers/usb/chipidea/otg_fsm.c index 6ed4b00..5ed9164 100644
> > > --- a/drivers/usb/chipidea/otg_fsm.c
> > > +++ b/drivers/usb/chipidea/otg_fsm.c
> > > @@ -471,6 +471,10 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm,
> > int on)
> > >                               return;
> > >                       }
> > >               }
> > > +
> > > +             if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> > > +                     usb_phy_vbus_on(ci->usb_phy);
> > > +
> > >               /* Disable data pulse irq */
> > >               hw_write_otgsc(ci, OTGSC_DPIE, 0);
> > >
> > > @@ -480,6 +484,9 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int
> > on)
> > >               if (ci->platdata->reg_vbus)
> > >                       regulator_disable(ci->platdata->reg_vbus);
> > >
> > > +             if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> > > +                     usb_phy_vbus_off(ci->usb_phy);
> > > +
> > 
> > Have your platform used OTG FSM? If not used, do not need to change it.
> > Otherwise, it is okay for me.
> > 
> > Peter
> > 
> > >               fsm->a_bus_drop = 1;
> > >               fsm->a_bus_req = 0;
> > >       }
> > > diff --git a/include/linux/usb/chipidea.h
> > > b/include/linux/usb/chipidea.h index edf3342..ee38835 100644
> > > --- a/include/linux/usb/chipidea.h
> > > +++ b/include/linux/usb/chipidea.h
> > > @@ -62,6 +62,7 @@ struct ci_hdrc_platform_data {  #define
> > > CI_HDRC_REQUIRES_ALIGNED_DMA BIT(13)
> > >  #define CI_HDRC_IMX_IS_HSIC          BIT(14)
> > >  #define CI_HDRC_PMQOS                        BIT(15)
> > > +#define CI_HDRC_PHY_VBUS_CONTROL     BIT(16)
> > >       enum usb_dr_mode        dr_mode;
> > >  #define CI_HDRC_CONTROLLER_RESET_EVENT               0
> > >  #define CI_HDRC_CONTROLLER_STOPPED_EVENT     1
> > > --
> > > 2.7.4
> > >
> > 
> > --
> > 
> > Thanks,
> > Peter Chen
> 

-- 

Thanks,
Peter Chen
