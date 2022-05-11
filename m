Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A24523E49
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347513AbiEKUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347496AbiEKUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:03:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D0F1D48C7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:03:02 -0700 (PDT)
Received: from mail-oa1-f52.google.com ([209.85.160.52]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MvsN5-1o6P6A0YHX-00sry1 for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022
 22:03:01 +0200
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-edf9ddb312so4141668fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:03:00 -0700 (PDT)
X-Gm-Message-State: AOAM532PDuKoVAQfmNz+pAfHU7HOjMht3/z2r7jVXqg9YfxmJbdS7+k5
        uksRlSEaUdqUOMhGCcKxmjye0IoMfftrN2/JyiY=
X-Google-Smtp-Source: ABdhPJwwPw4+8p8VgoM3olKQlDqsXwX59vFNT4ipMIqp/8fatnE0NT9ZkM+0jaPJODaBSx5ZwEBPTq9Ovo9Espj6BpE=
X-Received: by 2002:a05:6870:a1a0:b0:e2:9331:cc30 with SMTP id
 a32-20020a056870a1a000b000e29331cc30mr3527723oaf.155.1652299379884; Wed, 11
 May 2022 13:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220414193316.14356-1-vdasa@vmware.com> <87levezr2y.fsf@redhat.com>
 <245F4717-CF83-40BC-BC87-5EB8563E0588@vmware.com>
In-Reply-To: <245F4717-CF83-40BC-BC87-5EB8563E0588@vmware.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 May 2022 22:02:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1yCBO5fJ8pacxVd4Umjt0Qy7wfgwZNkqqYMKjofZFvLQ@mail.gmail.com>
Message-ID: <CAK8P3a1yCBO5fJ8pacxVd4Umjt0Qy7wfgwZNkqqYMKjofZFvLQ@mail.gmail.com>
Subject: Re: [PATCH] VMCI: Add support for ARM64
To:     Vishnu Dasa <vdasa@vmware.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        linux-kernel-review list 
        <linux-kernel-review@mailman2.vmware.com>,
        Cyprien Laplace <claplace@vmware.com>,
        Bryan Tan <bryantan@vmware.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WQ6gu7PTblLsIW6IjReqHkUG3Lg6MqN0pXFB1gjkxKGzPONMIjL
 aXaM0tEeicZyIJ/aypFttIy8Idd73UAixsfIyYCdCVGWkwGGOWpD687ovj2fQ1cwW+ZcV4x
 cxPsj6TxTBAtHny8mPjjph//wjC737+zQShRlLjMAm1nh6iR3DhCaM6WUwoy0HR0+Nn+u2b
 71nOpnDGCF0EUJD1STSTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j4SDC6m2XHs=:8Co3tPJ0W0vyTISGndl3lG
 ob4z82U6/ESP0AKt4wW9mzPhUBRbTDHyWHyV2gYIqOwINk4NWJXwC2kzbLmJxJ2xi0bpF+kNy
 ABAuhQ0r/3M2X8Pd9nYuPdjoZa0A3fN+n8w3/XHc4p41yJ3r6M2Dr5tbOJ+G2BDaNyEGfb3ln
 KFFDNY8oDtDD3IFMYds4H7xOYHeNJyl8ot4NQ0DxzbuuPyEo3LF7MDWZrIcuuBZXxN6hY52Em
 1msWDR0EPaXPXgCmm9ope2XK6tM1lwS4KFc56OSojn3RJMUrDo5z3zpl2XEr9rMMaSHZLde/S
 gwvH6SGIUOaLkmOdQuij3ETubuky9yRUxMEApeZxYDIVSicsk+ccVUJnLvZGtazh+TsRaihmu
 4sDyklIStGjNjtOtoM51idbv6ET+LunLaXhH1rSuLRSIGm55XJyDEWflX+3OwCTmK8meXruL4
 nxX3ANfvT7auAYPakLHN1xcA/rWgaNgpEXBjRfHxNASEE8i8dTrc0py22p3iTLVue5e2lygxh
 RQ/Nn4EQfOUZpUd0MkqQREXw8Nv/3J5ORteJYCiehfrxv+2gL4pdWIDcW1xNMj8lrhlET0Hix
 rkeYpyt2DmL+a/UW8NlcWSO6TFxZ3tL0Gd9orIRzhmjUVNQRzQYx/j4BO4e5GH+XGHA8ncxy6
 nxCDpDgAtrtzdvt6AmHvRKwshFWTAMPu1TpRq+UT3oa6HiA3o5pucsSQCHeLo/yyvMKYYQAAu
 1DZm3pv5I4dY2PXM8kLbXiYRPujdEUNJgW1JRA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 9:54 PM Vishnu Dasa <vdasa@vmware.com> wrote:
>
>
> > FWIW, it seems you're doing three things at once, better split this into
> > a 3-patch series.
>
> Thanks for the feedback.  I was debating between the two ways of doing
> it and ultimately did it one way.  It is a bit late now to change it as it has
> made its way to linux-next already.

It's really ok either way here. While there are clearly multiple changes in the
source file, they are all trivial, and the Kconfig change doesn't make sense
without the other changes, so having a combined patch seems totally
reasonable as well.

         Arnd
