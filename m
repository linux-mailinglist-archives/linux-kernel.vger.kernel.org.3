Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4859CA70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiHVU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHVU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:57:33 -0400
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF648EB1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:57:31 -0700 (PDT)
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
        by mx0b-00364e01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MKsT95018473
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=pps01;
 bh=pmg5gaD6jVdPDjUGFaBXIEiTNhxDtTS1VsBu4BaXMQ4=;
 b=YI7zG5fMjLn/foIYWsxJzEFdvShwmu0dzqAseQa+HWkek0nPIVt9FnOScV6UDvLZUWYN
 zI30m3wy90qHXoiy1eCCGknAqhSv0CpWnGxTQWc8IsG31aXA/QaNcdiea9BOtcFrvBTo
 wenbZDPSc8SXMUbvu3TlLnqPa/W5PNHB7kg2a7D/vWx6n58gruMTLKUZbPulIL5GzzGB
 j7puF5uCnY1XGjDuIlTnTTsuEQNRvdd6bV1h8NF9mI9QSwZgxOoGsOo3rT5BFlhMY31Z
 CY2077rkVYOIqvZu9QEvqpHvB3KQR7dP6hasmN6LkFlB0ph1iNe7K8whG7IjRTCtxfrV Lw== 
Received: from sendprdmail20.cc.columbia.edu (sendprdmail20.cc.columbia.edu [128.59.72.22])
        by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 3j2wj6dkhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:57:30 -0400
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
        by sendprdmail20.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 27MKvTmM095630
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:57:30 -0400
Received: by mail-vs1-f71.google.com with SMTP id 63-20020a671942000000b0038c9055e83cso3312390vsz.22
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=pmg5gaD6jVdPDjUGFaBXIEiTNhxDtTS1VsBu4BaXMQ4=;
        b=GaFoiPhckQ2F9TiNepzmIeKjYkTUNaEY97A9MDHlxSKjTz4nBh3Y2gL1S/B1XP4IE7
         V+GDduAH/qqj+UeY8O4TvBAlDeT/ur/sg+TFt/aeG0EGCQWkHjdN2OqB6tTDJ01chNGc
         KVrzu7hsKUfzyH5CmvJ3tGW1qLUs1qu+B8tP9WmhuGOKha/vWHxXvZ3bue07d1FxobpZ
         wO/DG1xhajncKkWMIboRuyQxtkhNgVb4LH0NScQMUDRaLOF7ucI+QnVz2xczM0Ox53CJ
         zpZ1PoxuyTBUzJmnt0Y5qf+SJrp/cnFgyPXOC7S4zmQL/E+cMDtKx4qE6i2SOrfUC8Ey
         z81Q==
X-Gm-Message-State: ACgBeo1SY+1j799WlmdVDI2iCsr4LllBnWvCVuu5k7aiJgbRts7oU1zk
        /RyxPmsilnSK4DLBuqbk0R4bUoum89YsHsaPGTzZ+XVipcbAWlaWfkwKTmHeMp9h+fqAAGMDeNs
        ywJad7nI27xenLc6l7qb01xUfV0aEQ705MwOA7T650b66nWiy
X-Received: by 2002:a05:6102:7:b0:390:3c74:936b with SMTP id j7-20020a056102000700b003903c74936bmr4614051vsp.72.1661201849454;
        Mon, 22 Aug 2022 13:57:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4YzC52oEHk+7YRy2zmdwGlDWS1lFcinvN6MCeC0KJRnvhLyjXdIfTBRCa/pvOJXVQBTPfE2RBggMlT9KnfAaA=
X-Received: by 2002:a05:6102:7:b0:390:3c74:936b with SMTP id
 j7-20020a056102000700b003903c74936bmr4614040vsp.72.1661201849258; Mon, 22 Aug
 2022 13:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHB249P1XurGDtvfjzkEzP4qWEaL6FG4ENM=PYjk7-JZfnKrQ@mail.gmail.com>
 <Yv82cwVT9MXX2nx/@kroah.com> <YwHw4IlvxWgCrhB4@kroah.com>
In-Reply-To: <YwHw4IlvxWgCrhB4@kroah.com>
From:   Gabriel Ryan <gabe@cs.columbia.edu>
Date:   Mon, 22 Aug 2022 16:57:22 -0400
Message-ID: <CALbthtfJ66kB9cfthCAML6NmGnV9N0VmnObcZy=XePza+8A-ew@mail.gmail.com>
Subject: Re: data-race in set_console / vt_ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        bjohannesmeyer@gmail.com, jakobkoschel@gmail.com,
        xiam0nd.tong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: hfNni1MuAg4DFsil8pVfJNLZpE4kXM8Z
X-Proofpoint-ORIG-GUID: hfNni1MuAg4DFsil8pVfJNLZpE4kXM8Z
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_13,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=10 mlxscore=0 clxscore=1015 impostorscore=10 bulkscore=10
 suspectscore=0 mlxlogscore=317 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220084
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I want to apologize for not responding to you and the developers who
wrote back regarding our reports earlier. Moving forward, we'll
respond to all developers promptly and follow the researcher
guidelines for reporting bugs, including submitting patches and
sending reports in plaintext.

Best,

Gabe




On Sun, Aug 21, 2022 at 4:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 19, 2022 at 09:06:27AM +0200, Greg KH wrote:
> > On Thu, Aug 18, 2022 at 09:17:00PM -0400, Abhishek Shah wrote:
> > > Hi all,
> > >
> > > We found a data race involving the *vt_dont_switch* variable. Upon fu=
rther
> > > investigation, we see that this racing variable controls whether the
> > > callbacks will be scheduled in the console (see here
> > > <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__elixir.bootli=
n.com_linux_v5.18-2Drc5_source_drivers_tty_vt_vt.c-23L3032&d=3DDwIBAg&c=3D0=
09klHSCxuh5AI1vNQzSO0KGjl4nbi2Q0M1QLJX9BeE&r=3DEyAJYRJu01oaAhhVVY3o8zKgZvac=
DAXd_PNRtaqACCo&m=3DHh6zVRwx03sES-_rP4nbiMMLKzf33Fyrl7-aPu_mxJ4swlpUvEkjtoZ=
Rlyp30wJ4&s=3D5y1FdmpojkxZev__sRBMbryhzfGe1AApYJ3AFOy34HE&e=3D  >),
> > > but we are not sure of its security implications. Please let us know =
what
> > > you think.
> >
> > Again, any patch that you might have to resolve this would be great, as
> > that's the easiest thing to review.
>
> Given the your lack of responses to the developer's responding to your
> emails, and the fact that all of your original emails were sent in html
> format which was rejected by the public mailing lists so no one else
> could see them, I'm going to just drop all of these reports as being
> something pretty useless.
>
> If you wish to submit future reports, please read the
> Documentation/process/researcher-guidelines.rst file on how to do this
> properly in a way that will be useful, and be sure to actually respond
> to developers who take the time to write back to your reports.
>
> This is not a one-way process.
>
> thanks,
>
> greg k-h
