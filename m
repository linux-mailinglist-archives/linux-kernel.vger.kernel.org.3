Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23547F1B3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 03:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhLYCR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 21:17:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:37455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhLYCR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 21:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640398618;
        bh=pfHDFwQwt/QEbu1J8kSPjMYX72C93NC1b1/5lK97LUg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=K6AQmI49QdGNawE2ZktRsdsZOhBQnzKeW/5LysgMxdfUnXSYOlFJm/ut5d4mc0ydF
         HqTaqZfNo71wwMf+39DvuU416UWEXAUmzlFR19oNHiQbQXmVlVEGxmQOPEIXZ2mZOn
         jpWHjGI43KpWcRdHiG7fIXM+j9uN3uxW1muTdFCk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.63]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1mIhjN2Plj-010cNc; Sat, 25
 Dec 2021 03:16:58 +0100
Message-ID: <64294bf40ace6be86a295099b895a7d1f6a5c49f.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.16-rc6-rt12
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sat, 25 Dec 2021 03:16:57 +0100
In-Reply-To: <YcSgQY8lzb6MkQPx@linutronix.de>
References: <YcSgQY8lzb6MkQPx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xeet9qeBg7VpsyOjK6029ybcbWO5Yw1TQTT4t0e8vF2l8PTRZxs
 o1S61a6LXxR+Wjzzv4P16Bw/YwlKL2g5ZlMEkYsyYt8O3iG0QLgKViHXiUSvtw8zYf9ONrr
 swHSM8nnySoxWll50aO6Bqtus2OUdt2iBx6BocNJ7CADQkG6YlFlJ772ksySFyvBdZUjlLS
 8gQVVWBR4vsHvGbdXOl9w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AdK+zt0ryVI=:Y1sgYqxSL50lHxpj4T2e12
 I/lFZN5YGWd1mQJjwcvgE/IHbOzaNVtUXr6cWXqfcru8k7K+bEQHkDm4yLtz+5Js+qOvxpE3W
 wcw7wfUlZPSo7VPgxS3hzaCaHVrBUM3y3e7sbvhbF4M8JplztGmoN/ME8W3VVWUSS7q5TTwVC
 XCGujLJggQ7QBR6vhoAfBpcMD5eUDHVtNLsmBa69alMzg/8i8e2PVhbm/soNHXHBTvBYHNZhy
 UPRXP4jOBCU/jqx3sXerY4FCSqnHSLC5ZHTQ2s6p64VCEc/gukLxefcTxmBwFQ8DjlAzMF/Kb
 HmiAJmeJfDs/fxMf4YKeHFEf3duAubbWfPzZZPkB47HI036PkJiMe1GWt+RbeLrv63h6GF64H
 DLP2Dcx0BhZWOY4XksMzWF1uT6Vq7Mb+qKAFamtlyaav00fSDlyB3RV8P1Oo0clSmFdReJ8kt
 eC0CddsmDhlX6Cy/NUTm8ksW/Gad8J95ZAGmipHcyNfCJEpFlk5XdHo5ncppRDZWtXaNX0/g0
 kQTRtUe25RQ3vAx1DsFFmDvUDWv+VHJBzL+225+vtWZZWqqbGF14t0ONMeWeCAYUCUd/rmwLn
 Ay8VPo4ldf1d5RbN4gnUkiiLhVB/erVVRfhqEo0Hi8AAZRBQ1U1c0kGZbVVEeng195ogBZhIA
 1R+M59noy59Klts0rWzfheik223XB+DCDTJVrRdKJ8JdYIYg4IFBCFfNhyP2OdHnxbCkY1OoK
 KXjWDty79Qf7QEClCH3crIu3L4ewBtAQMBxWEhFGpHkhIH0y5D/2OWaKbtWBqyAO6Jo3zPONg
 EWmSsh3Fzo7imjXL6a27vr+VpJVIJI8COcUQJGUWdXwtr3ARCg1EUy7APT6zfUuh1wXFIx5pW
 VytoSoMpjLWS20TP7kk5rwNiVTatqqt7sB1WYtP0DReUvWBZzgbVisUGeejOPznCNVOZ4ey8U
 upm9HEhYqgIeSAN+UfeaznaXmAXTm9IOTKUvx3Vm6a3hOnnSfYHcbEBjIVXd6+lUUBs6PLQ4C
 JtNkWgGpBNan41w3dsqV+VCNM+2HN1QBS/sfrnJ2iR5ucIMKWICQwPOhtx9ce78r1Lofk/p/S
 vbgAkskIMFIFK8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-23 at 17:13 +0100, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v5.16-rc6-rt12 patch set.
>
> Changes since v5.16-rc6-rt11:
...
> =C2=A0 - The "Memory controller" (CONFIG_MEMCG) can be enabled again.

FWIW, LTP testcases pass on rpi4 and x86_64 boxen with no gripeage.
Full LTP with maximally bloated config was as uninteresting as one can
hope for.
