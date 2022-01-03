Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DAD4836C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiACSXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:23:41 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:7660 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235504AbiACSXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:23:39 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ALVTLfqLVsy/L5E8IFE+RwJQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC+0Dhx0DVTmjFLWDzSaauKazf8eohyad7gp0gE78TUm4NqS1BcGVNFHysb8?=
 =?us-ascii?q?5KdbTi6Bh6tZH3KdpWroHqKXqzyU/GYRCwPZiKa9kfF3oTJ9yEmj/nRHuGkUoY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWHULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssItO?=
 =?us-ascii?q?snqz6f0tirrz6bVXI1CoQAvL7xEEd/UTe0Y5iXBYYQUVKjzSA2dR419xJsbSxT?=
 =?us-ascii?q?x0oN+vCgozxVjEBSH0iZvYap9crJlD666R/1XbuaXLiyvhqJEI7J4sV/qBwG24?=
 =?us-ascii?q?m3fcFMioKbB2ZivCe2rOgR/R0wMIuMKHDJ5kevHB+xCqfFf8gTYreXazG7Pdc3?=
 =?us-ascii?q?TEtloZPG+rTY4wSbj8HRBDNZRdnOVoNDp862uCyiRHXbTxCpUmV46kq5mHJ5Ah?=
 =?us-ascii?q?w1rH3N5zSYNPibcFUmFuI43rD13r2DwtcN9GFzzeBtHW2iYfnmSL9RZJXF7Ci8?=
 =?us-ascii?q?PNuqEOcy3ZVCxAMU1a/5/6jhSaWXtNZJEs84CciraEuskesS7HVRxCkrWSWlh8?=
 =?us-ascii?q?aVcBZH+Az5EeK0KW8ywSEHGlCSjNFbN0OrsI6RTU2kFSOmrvBGz1pu7CTVTSS6?=
 =?us-ascii?q?7aIsTSuESwUK2YYYmkDVwRt3jVJiOnflTqWEY0lSfTsyIOlX2GthSqHsm4lia9?=
 =?us-ascii?q?Vi8MXv5hXNGvv21qEzqUlhCZsjukPYl+Y0w=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AdqX97KrG0hXOTTiEp7DNN+YaV5oseYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG885x6faZslwssTQb+OxoW5PwJE80l6QU3WB5B97LYOClgh?=
 =?us-ascii?q?rKEGgI1+XfKlPbdxEWutQtt5tIQuxOTOf9ClV3lq/BjTWQGdxI+ra6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.88,258,1635199200"; 
   d="gz'50?tar'50,49?scan'50,49,208,49,50";a="13443347"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 19:23:38 +0100
Date:   Mon, 3 Jan 2022 19:23:37 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Francisco Jerez <currojerez@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2201031922110.3020@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net> <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com> <878rwdse9o.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112281745240.24929@hadrien> <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com> <alpine.DEB.2.22.394.2112281845180.24929@hadrien> <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com> <alpine.DEB.2.22.394.2112301840360.15550@hadrien> <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301919240.15550@hadrien> <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com> <alpine.DEB.2.22.394.2112301942360.15550@hadrien> <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-889477284-1641234217=:3020"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-889477284-1641234217=:3020
Content-Type: text/plain; charset=US-ASCII

> > > Can you please run the 32 spinning threads workload (ie. on one
> > > package) and with P-state locked to 10 and then to 20 under turbostat
> > > and send me the turbostat output for both runs?
> >
> > Attached.
> >
> > Pstate 10: spin_minmax_10_dahu-9_5.15.0freq_schedutil_11.turbo
> > Pstate 20: spin_minmax_20_dahu-9_5.15.0freq_schedutil_11.turbo
>
> Well, in  both cases there is only 1 CPU running and it is running at
> 1 GHz (ie. P-state 10) all the time as far as I can say.

It looks better now.  I included 1 core (core 0) for pstates 10, 20, and
21, and 32 cores (socket 0) for the same pstates.

julia
--8323329-889477284-1641234217=:3020
Content-Type: application/gzip; name=132.tar.gz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.22.394.2201031923370.3020@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=132.tar.gz

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
1FQAXW6nKZ8S6eJCmNbcMp2n9bkmo6kvSzLTNxRBTrcsUJom5VwLGqApegLL
I9fGpioQFUqX8+zltU32hDbyUDZDTeLyXi7h16/Gq7xS2wwcZUbS9Rh5OlqP
NajEJYBl4NghaXnrVUkp4VJFulazg0ObWA+71EJYVMbAfEa5rwKBfqzO6k5r
Ete30ZUWyQWjmxRULZYpdPu30UF+jkt6KEbSBmODlOzgzkia8+PaLxtEtG+j
s9Se+a2TdQvGi1UCa91BUfsqEOVVJFg3LTQc7qBUJB30wdyeumlPf5rcOCJp
mYs0X6J7aqxJ7O68eaMiTxhqElsYODDK1Rn2eAi+ImlJ9bOTrepq63r5Orv+
dZJ9TWLIpRdOM0fryf4OSYOZ1Jldc2CXMmpn76JzuLNXOTxU9ST5DXJtFYjJ
2ybWm1Ll9csR1DOSlmnTzuYy2kaXV5jaaQEVmwut72oSzzKmZ4OYC+YYbhUF
SZUOSUMuGt1UTjjIW9Ajks61MVBeScjthk//LjrM77FtKjWjXMJtP1aByBV/
2npMZzspOCBpKrVVSmnjiZN8vovueT2v5/W8ntfzel7P63k9r+f1vJ7X83pe
z+t5Pa/n9bye1/N6Xs/ref3dXv8LcaN8cgCgAAA=

--8323329-889477284-1641234217=:3020--
