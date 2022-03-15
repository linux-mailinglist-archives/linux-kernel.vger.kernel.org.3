Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D44D9FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349909AbiCOQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiCOQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:10:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ECD42A3A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:09:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p8so20448449pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/3evLoiUxyduQgTRbFtXBiM1S258zVm+UJtnMloKak=;
        b=0YcD70QC0MgG+ea9Hyfe1KDOhrj7ONcEkvDRV6M9sMdA6lBfa3vlxGaB1+hzovZQOs
         nurK8WNaWNkB/vGSQtA4Lq31WE9AExhGngDlI+yUnN8qWySuU6IBhWONrdiHFdV6PG6B
         sbLG2d10zU9EuEgpQQ637mwVNaUrgXnqa/6yF3t6jaDhmTRw/xdLrWfPkJvFyDNuy3Xk
         WomPnsVYKvLH1B+xPE4kDOTzN85NvKrs+YT5dfMGxH9GSbsYL7HmtJwNrMD/6pGis5Js
         F89yrxdEhLffsaTI1cft4JLc1BxFIVR1hgR2KurWjoapaPEJuPPbvYpjO/lpEfCcpLue
         sU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/3evLoiUxyduQgTRbFtXBiM1S258zVm+UJtnMloKak=;
        b=pp7sz5dQ4LKPOnN1HqxvTHebZNBqXqSmUMeamvmMYVzB1TCDJvywiya21pIVseXtrk
         dHcTukfAro3EcaoyZMGWqII96fbclOiAgMidP0Gcw/4e0QqEVsMWOimFONRxWF2cFwpo
         UYIr21cznUv0xw/Xgfmxpc560pIAeGFhXdmiWkoBlF9E+UIH1G6ZSobos3gZqhzIsybk
         dpDY9niKstQweGlUzNPCPDeBqDpfdhkvFGgt+bUgcV0srDl91ANPEBlILMzIy8lXqsn/
         s8WZP1znFqN2nqZvqEJiwnQ9tjUg2WuMU1gQPR2AZS9qM+XM2d55xT3Qh52bvMKqFOba
         30Xw==
X-Gm-Message-State: AOAM530La2Vb4tQFbkKZI7Ip2uPDMsrbStQ/QVRSCepqd+G6lAwEWaXU
        7UnEy+xyv8l+MF/OnvchP4J/QPdnJ8XCN3eu92c72g==
X-Google-Smtp-Source: ABdhPJyMgwt0K1/knvdgQkdrvVvr4QZNZtkwOk/zi74i6418fAFiBNttZxLgdpHinFyQTs23rFNvPhfWer6YMjV+1IM=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr29577774pfu.3.1647360568827; Tue, 15
 Mar 2022 09:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <Yh59rOIH24X+6GyI@kroah.com> <Yh5+om/Nr06V0+Qj@kroah.com> <Yi/Lb5laEki0JHft@agluck-desk3.sc.intel.com>
 <YjBBmEjbIaqTbVt+@kroah.com> <c4af81bd788e43dda915a1052af0be55@intel.com>
 <YjCwI4N00reBuIqA@kroah.com> <CAPcyv4iU5mXAjkUe-c_-Ba4Ejse90gqd=db+00jybnkV1-K6=g@mail.gmail.com>
In-Reply-To: <CAPcyv4iU5mXAjkUe-c_-Ba4Ejse90gqd=db+00jybnkV1-K6=g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Mar 2022 09:09:18 -0700
Message-ID: <CAPcyv4gdbjHem9zwoCjj+6a2KJ5dyYro3OwPvNLSPTKpjeF0hg@mail.gmail.com>
Subject: Re: [RFC 00/10] Introduce In Field Scan driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 9:04 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Mar 15, 2022 at 8:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 15, 2022 at 02:59:03PM +0000, Luck, Tony wrote:
> > > >> This seems a novel use of uevent ... is it OK, or is is abuse?
> > > >
> > > > Don't create "novel" uses of uevents.  They are there to express a
> > > > change in state of a device so that userspace can then go and do
> > > > something with that information.  If that pattern fits here, wonderful.
> > >
> > > Maybe Dan will chime in here to better explain his idea. I think for
> > > the case where the core test fails, there is a good match with uevent.
> > > The device (one CPU core) has changed state from "working" to
> > > "untrustworthy". Userspace can do things like: take the logical CPUs
> > > on that core offline, initiate a service call, or in a VMM cluster environment
> > > migrate work to a different node.
> >
> > Again, I have no idea what you are doing at all with this driver, nor
> > what you want to do with it.
> >
> > Start over please.
> >
> > What is the hardware you have to support?
> >
> > What is the expectation from userspace with regards to using the
> > hardware?
>
> Here is what I have learned about this driver since engaging on this
> patch set. Cores go bad at run time. Datacenters can detect them at
> scale.

Tony pointed me to this video if you have not seen it:

https://www.youtube.com/watch?v=QMF3rqhjYuM
