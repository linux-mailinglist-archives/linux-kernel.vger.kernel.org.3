Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FD34B812B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiBPHQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:16:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiBPHQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:16:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03212B0A68
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644995747;
        bh=suHsgXH+UCaPUEi9/z5ugIGYdtAIwHSMAlsMljlrGoo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Fk8xN8WzP+iC0JHRacbgt3/YFUiTv2Ap6uW7L08ZhMwrRnhIbs68wGHvOjPpNrl7w
         Vfm3oTEbqIjFpfKagn/LHr+O05+j0OKVoqypM2qopwkC7j+pkiDuu6fAcc9It3zW+c
         mjGtVBpHMPGS125soe1BQjRPYSjjmkfbNWoi438s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.128.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1noWzk3GcQ-00WYiF; Wed, 16
 Feb 2022 08:15:46 +0100
Message-ID: <b6632459-92ec-8c79-6221-e0b3754b1f97@gmx.de>
Date:   Wed, 16 Feb 2022 08:15:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [deller-fbdev:for-next 51/51]
 drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:49: error:
 'component_compare_dev' undeclared; did you mean 'component_master_del'?
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Yong Wu <yong.wu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202202160743.MUYvzd9B-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202202160743.MUYvzd9B-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xdie6Bbv34PAIA1OJ/AkOe0LxEk9/dtU4Q4k/KhjKQuchEkqz83
 M9saUWorgUnmmB2B47tR/QKjzsgv+jCyNO5Vpr8/eE7ASDvc/W0DPeYQ/Tr/Gu0luKItZCh
 e3KxUwlH0KS6IoOvXpbbRtTk0C/wDTudmKDJzFH1VHgeEjGCdKXxK7SUV1ZAF5X8U8ewrgy
 AKCKb2Get4XE0bYCoA8nQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:32wVd1S1KoQ=:GVw57s6Z5RH6wYdti6I31x
 m0Zj9oAHif/tJ8c36Y5oE2ZLtVeWqHiy/7t+uU+Yo+oOF/9k2uk3Z3KVHGJReLW2ycgQkRLKs
 vsVJVtVPQ4vyEHQlPIjQav+NqbzjgkAcQjsApIZA40mRkz56fYAY/zZbvohvQzB6prZD4R7Wa
 1VTD77UYu65iAiXLHLIOOmkrCoGpT6vexIcavfVtgSHzMBMC9+gPlnB2zwEBsHl6vHi4EgwZd
 QLEmbwm/XWiTnHNiuSh1ns/ToK0Irv4rm5V/KHwRdp2sawh4cdN56KklDOdelHBd7IIg3Nb2Y
 ZIjC5LCu9FlJViuHdwHbj8BlfipnIoXW3Oud19pYs8bJ2+I95xZUjrSh/lTL4mzvZmsU21wB4
 tWUFwyan5VMKhSu1jWdc8lrbl+My1wR+QHZXKr2qU+SisBl7ruOxhTvnksov9gK4FHuYiUz6H
 e/wBOEcAAyRvouuz5gOfAkb40XLG/QpNVB1EavYW1j8vVRJJx5EhkRsog3NzkSsb6RC/vNBvu
 30cKCGWVsZ5d0df4xt2jVuai5z2VrZ9Ff947uK22PehCpemFN1G/wN7F2BQrGjYXw0pqN2HQw
 3jRdy1lgnljdCiOpqpCjd94X+t5yp7HMYcbiqjBlzgPPinL0r0Z/WtPcA2gUDNdPyoDWLQz0o
 nqtC7N2E6SU0c7TfEvVfwG09VldBv1wpQjhq94yf7EK2vgnswIYMdzkezKME3F4vD7j+rmoDb
 Td8u47P8m2TOlOjf5zCf1eg9eOVIpepg7v54+EyeZmr9r3Oak0CKTDPrheBKpYixxqDSNRosh
 vXQuV4y4vEI6YrCXlgz0NiHjeL9cGZqpum4j4DFilQ3B30WsrpOnl6eTmG1Ip0xHVT8qNqyyL
 Kms/h/JWzSuyMB5CQ5Zz3RZNMY5I6Y1f4fG9JmhMjXzUhbONXfHdKqT8Ya8iggDkAGwwAFqnC
 RbZ3KFjtv1vvqcRu5czRZqZBAyPlpOOI0UpCNlYwaMYVV9Kn7I712YDwfjGC+CFXqyyQrCzjQ
 A4yKNTh9ANSZPOTMBUsyO0hBLzHeG1qImJ8OtU2JE/IDMlzEJJtACSz4JVA5mF0PoNXv9sXMY
 6p/BYDjatk/JAE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 00:49, kernel test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev=
.git for-next
> head:   61038027aa13351c63b452a0d48c805bab1d2ce9
> commit: 61038027aa13351c63b452a0d48c805bab1d2ce9 [51/51] video: fbdev: o=
mapfb: Make use of the helper component_compare_dev
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/2022021=
6/202202160743.MUYvzd9B-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-f=
bdev.git/commit/?id=3D61038027aa13351c63b452a0d48c805bab1d2ce9
>         git remote add deller-fbdev git://git.kernel.org/pub/scm/linux/k=
ernel/git/deller/linux-fbdev.git
>         git fetch --no-tags deller-fbdev for-next
>         git checkout 61038027aa13351c63b452a0d48c805bab1d2ce9
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss O=3Dbuild_dir ARCH=3Dsh SHELL=3D/bin/bash drivers/video/fbdev/omap2/om=
apfb/dss/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/video/fbdev/omap2/omapfb/dss/dss.c: In function 'dss_add_chil=
d_component':
>>> drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:49: error: 'component_=
compare_dev' undeclared (first use in this function); did you mean 'compon=
ent_master_del'?
>     1209 |         component_match_add(dev->parent, match, component_com=
pare_dev, dev);
>          |                                                 ^~~~~~~~~~~~~=
~~~~~~~~
>          |                                                 component_mas=
ter_del
>    drivers/video/fbdev/omap2/omapfb/dss/dss.c:1209:49: note: each undecl=
ared identifier is reported only once for each function it appears in

Fixed now. I've dropped that patch.

Helge
