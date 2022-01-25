Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126B949BC45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiAYTkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiAYTkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:40:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC6C061744;
        Tue, 25 Jan 2022 11:40:03 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n8so18399019lfq.4;
        Tue, 25 Jan 2022 11:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tduuesxq4hZpsXCln7SUx3iQzE99K3TTjs0yDxRG/Yw=;
        b=YaZ1s4EOfT/xURCNUJ7ljTeO1+Sr8ERLBWB+TaU8n79uLP5u7yXPf8XBygAD4VQsNH
         J4jM8g1svCtsX0kW47011E2cKo8RUb68yYpRoqxTysQMoI9YspjrV3XO0B7J4E8vY6OW
         enFoqoe7lU1TKO1sFS+KpPLDlsaR7aRd4iTR7BkJ44c11APqRS03TRLMQkPZuT3CMrkI
         q5Hu8Sd1XAqi8gGruEIz35uHhEk/i+/yKnoP5qjwaEqS5VL5hyiw8lwSfCEF/7SqL62l
         7y3z8h1MuuuvbVXWvYZrLFxgKLC5O9Plt5ybxYZ2arFtsmTf54f+TbLzl0kakgeZzi2N
         cL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tduuesxq4hZpsXCln7SUx3iQzE99K3TTjs0yDxRG/Yw=;
        b=j++Zxw7Y/lPpiPOglDI5aZM+ok4W3YWBof0Fz2qcGaUuBmSzYpdKS2+2MfueaMBEGs
         ZnmHxfSyrX8CxhCQGTHVebSghDCiiCyUpocuqVQIT85Y4i/ZLJyRLHJhEN/86HZzmdZx
         ACCYwgyRy/EwfC6h4AbeX4THGcAn1HeUPMCs229Fss6AHqbNosSXSlTf1DXVteqRZygC
         trfG3hjsywqq7fB/fXmYNsy9w4Ark+SZe3NnEsjEtcoOrOX2Yk3kpQgNmKa7E2dZ+3aC
         tNXISGGg8j+VlZDC7dqx2gzPcuIwa0NjHl3LgdNhwzMAcSLNH7VZpoZNgtbMNRNEaWlV
         UU1g==
X-Gm-Message-State: AOAM531YV/IRaM7cunMJkpMm1Sbm43zmwQutw3HkYduBXrZ79qp1ZSxp
        gnFCSwdx7SMExpPu5uudrSK3AwkZ0eUi/78cPTQ=
X-Google-Smtp-Source: ABdhPJwA25TgpbVOGFVpZkvzEypgG/YO9KRxt83JO8OsOWlZcjrL0PjPaf+E1o/Y8FngcqRhLtO/opJOvONyjKMbJdA=
X-Received: by 2002:a19:4945:: with SMTP id l5mr17220627lfj.595.1643139601812;
 Tue, 25 Jan 2022 11:40:01 -0800 (PST)
MIME-Version: 1.0
References: <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com> <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com> <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net> <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com> <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com> <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net>
In-Reply-To: <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net>
From:   Rajaram R <rajaram.officemail@gmail.com>
Date:   Wed, 26 Jan 2022 01:09:49 +0530
Message-ID: <CAOiXhaJPvs5hx_7wFyTm=npvojcF4WOGdnTACSgCOAvJD86i7w@mail.gmail.com>
Subject: Re: earlyprintk=xdbc seems broken
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 24, 2022 at 04:55:22PM +0200, Mathias Nyman wrote:
> >
> > > [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
> > > [    4.984106] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
> > > [    9.946159] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
> > > [    9.946163] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
> > >
> > > [   12.818364] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> > > [   12.818373] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
> > > [   12.820360] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> > > [   12.820363] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
> > > [   12.821036] xhci_hcd 0000:00:14.0: xHCI Host Controller
> > > [   12.821040] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
> > > [   12.823451] xhci_hcd 0000:00:14.0: xHCI Host Controller
> > > [   12.823453] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
> > > [   17.115089] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
> > > [   17.115163] usb usb4-port4: config error
> >
> > Ok, I see it now.
> > Your setup has two xhci controllers, earlypringk=dbc enables dbc on the first xhci
> > it finds, which would be at 0000:00:0d.0.
> > Your cable is connected to the second xhci host at 0000:00:14.0
>
> I suspect the first xhci controller is for the usb-c ports on the
> machine, while the second one has the usb-a ports covered.
>
> Now the documentation states we need this super speed A<->A cable, but
> could you also update the documentation for usb-c ? There's a fair
> number of usb-c only devices out there now.
>
> C<->A and C<->C cables are fairly easy to come by, would they 'just
> work' ?

I have used DbC with USB-C to A and it works
