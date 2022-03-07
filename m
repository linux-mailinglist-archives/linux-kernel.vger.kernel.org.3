Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73974D084A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiCGU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbiCGU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:26:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B520077AB8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:25:44 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b8so15110036pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 12:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xPG1LPBOa3H5DXgR7o2GVthpw5QsjXLM5bhO2dJz9eg=;
        b=3zqPzwHXruTQcNhNiuVXdMYLz9mOcP2ODa03H6FRv5SnwImp/QMEzWcuYMDmNlNvm8
         3Qcui9WxYTowX2u73fENSFhYvJ4v02NSin3QtpQNkLS5klt/b9KcBD70GVju6BTyk5N+
         Hw6T4W8/wnLVvaHKwZum126S2yjs1ENRrVfmx3/83CVRbbaiZ4NZk87fntISI4nxqACq
         Nxf0V++g2sZCkzbrEWcKQidffK1t64f2GDOou2YChtgkq9GYG5CmWhoKV0kJdfzm4fD1
         LNEEX9PFhIkdEGW4EBsxfgqRzNZgpD+ZMzImavjeg+p+l3quBMsv3/MWKz+l1K7Hm2Yr
         0Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xPG1LPBOa3H5DXgR7o2GVthpw5QsjXLM5bhO2dJz9eg=;
        b=fNaVrmEqFLbcdKlWuO/s1hcrOSY5I/uihwVe7oTUhsQls/D/ileMkCsIkLvNX9vWLM
         +KBdHMWqkn6EOB+ILzoEcjsuqed2lsvm2d2CJuWLnJkDm5Ud10iafsO1NysEtjwNSwYT
         /oNXlLDz2goUtU2NNHlpXl1G02RVpqnI0Iwxz64GU9254DFIDw2VD2g1FH2W71rZENkr
         G9ZoqVOxES4Qzbmia5rzju6uwIEY60YCa42pQxbcUIqmhF++j60+ttHNiBaSSuxet1d8
         3DFHO52yfZfuQZJ95HmPCfEm8Z1JVjkPGjzT2UXhzWI+/GAEgvxSS/3nak+uTuEqT/oA
         EgmA==
X-Gm-Message-State: AOAM532m9s/KCbwmZE08Cd0h3xn12wjj8pmZuIPHfF+XQdPQSTI/0NAW
        Eo3gjRDPLfrd2QeaNoljDPBiyBzaotJ5bgdYxmHB6w==
X-Google-Smtp-Source: ABdhPJyKCVE/WCuXCtJ9d0XP6J78Go2bCBz1K+vkzfzVhW+W1xRZjI98Iif9sjbcM0V3k79uOXzxLm0TSaxYSBaEU6E=
X-Received: by 2002:a17:902:d506:b0:151:ced2:3cf with SMTP id
 b6-20020a170902d50600b00151ced203cfmr14077231plg.147.1646684744183; Mon, 07
 Mar 2022 12:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-9-jithu.joseph@intel.com> <188492dc80c017375da76d444347b1d00c2031f6.camel@intel.com>
 <7b9c788e-21dc-eedc-a1b4-9c6877fa48fe@intel.com> <CAPcyv4h=qPFrP+mRqaZhkh5ZmYjuQawsqvf+-R036ZJVKBNK4Q@mail.gmail.com>
 <33d0e764-86d9-8504-17fa-14b31c87de4e@intel.com> <CAPcyv4g5bq9+u0iLjhpeJw8bkbCREUw60H2z_KfDz4hHCrKdFQ@mail.gmail.com>
 <7c620f8a-189e-5ac4-30fe-1fa14ba799ea@intel.com>
In-Reply-To: <7c620f8a-189e-5ac4-30fe-1fa14ba799ea@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Mar 2022 12:25:36 -0800
Message-ID: <CAPcyv4iUuZ0aAWckWvwbxJJgt5tDJRpeonfE4DegWS6KPtJq8A@mail.gmail.com>
Subject: Re: [RFC 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 11:55 AM Joseph, Jithu <jithu.joseph@intel.com> wrot=
e:
>
>
>
> On 3/7/2022 11:15 AM, Dan Williams wrote:
> > On Mon, Mar 7, 2022 at 11:09 AM Joseph, Jithu <jithu.joseph@intel.com> =
wrote:
> >>
> >>
> >>
> >> On 3/7/2022 9:38 AM, Dan Williams wrote:
> >>> On Fri, Mar 4, 2022 at 12:42 PM Joseph, Jithu <jithu.joseph@intel.com=
> wrote:
> >>>>
> >>>>
> >>>>
> >>
> >>>>>> + */
> >>>>>> +static ssize_t details_show(struct device *dev,
> >>>>>> +                           struct device_attribute *attr,
> >>>>>> +                           char *buf)
> >>>>>> +{
> >>>>>> +       unsigned int cpu =3D dev->id;
> >>>>>> +       int ret;
> >>>>>> +
> >>>>>> +       if (down_trylock(&ifs_sem))
> >>>>>> +               return -EBUSY;
> >>>>>
> >>>>> What is the ifs_sem protecting? This result is immediately invalid
> >>>>> after the lock is dropped anyway, so why hold it over reading the
> >>>>> value? You can't prevent 2 threads racing each other here.
> >>>>
> >>>> percpu thread running scan_test_worker() will update per_cpu(ifs_sta=
te, cpu).scan_details. (before signalling this thread to run, this lock wou=
ld be acquired)
> >>>> This is to protect against the scenario where if the percpu thread i=
s running a test and if at the same time a user is querying its status, the=
y would see busy.
> >>>
> >>> That begs the question why would userspace be polling this file? Is i=
t
> >>> because it does not know when a test completes otherwise? How does it
> >>> know that the result it is seeing is from the test it ran and not som=
e
> >>> other invocation to start a new test?
> >>
> >> I think I should have explained the need for locking at a higher level=
 .
> >> It is to make sure that only one of the below action happens at any ti=
me
> >>
> >> 1. single percpu test
> >> 2. all-cpu test (tests all cores sequentially)
> >> 3. scan binary reload
> >> 4. querying the status
> >>
> >> (There are h/w reasons for why we restrict to a  single IFS test at an=
y time)
> >> If 4 happens while 1 or 2 is in progress , we return busy.  My earlier=
 explanation was trying to explain why we are preventing 4 when 1 or 2   is=
 in progress.
> >>
> >> As to the question of why would a user do 4 while 1 or 2 is in progres=
s, there is no reason for him to do that, both the run_test (percpu and glo=
bal) are blocking.
> >> But if he issues a test from one shell and uses another shell to query=
 the status  (while it is still in progress) he will see busy.
> >
> > ...and what about the race that the semaphore cannot solve of test run
> > launch racing collection of previous run results?
>
>
> pardon me if I am missing something obvious here =E2=80=A6 but everybody =
(the 4 scenarios listed above) tries to acquire the same semaphore, or retu=
rns -EBUSY if try_lock() fails.
> So in case of triggering "run_test" and viewing "status" racing scenario =
you mention, the below are the 2 interleaving I see
>
> if "echo 1 >  /sys/devices/sysem/cpu/cpu10/ifs/run_test" gets the lock , =
the parallel  "cat  /sys/devices/sysem/cpu/cpu10/ifs/status" will return bu=
sy (and not the previous status)
> if  "cat  /sys/devices/sysem/cpu/cpu10/ifs/status", gets  the lock it wil=
l display the status of the last test result and  the parallel  "echo 1 >  =
/sys/devices/sysem/cpu/cpu10/ifs/run_test" will fail with busy
>
> This I believe is consistent behavior.

I am speaking of the state of the case where 2 threads are doing
run_test and polling for results. Unless you can guarantee that run2
does not start before the results of run1 have been collected then
they are lost in that scenario. No amount of kernel locking can
resolve that race to collect previous result which would not be a
problem in the first place if there was an atomic way to log test
results.
