Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114F14D446B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbiCJKYA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Mar 2022 05:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiCJKX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:23:57 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948892E6A2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:22:56 -0800 (PST)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MwQKp-1oJfuV3Fht-00sNwl for <linux-kernel@vger.kernel.org>; Thu, 10 Mar
 2022 11:22:54 +0100
Received: by mail-wr1-f52.google.com with SMTP id i8so7167153wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:22:54 -0800 (PST)
X-Gm-Message-State: AOAM530xC7SYxDVqGIkNhvR+R+1xKG4XKzf0kigibAooxCKEZQpWub/I
        yhdDNcliCEyQFqI6EXBBavC9M+3K8sG6lGeZLdQ=
X-Google-Smtp-Source: ABdhPJxLuwC/cXY7Kt49TsV0QMKpjI7NxzhH32ppEQt87QfFSN1WnLXl4LxC5A4SQh4xqnTVYHncPUASARKnWNh/o78=
X-Received: by 2002:adf:f606:0:b0:203:8dff:f4ac with SMTP id
 t6-20020adff606000000b002038dfff4acmr891995wrp.12.1646907774501; Thu, 10 Mar
 2022 02:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20220218212526.16021-1-pali@kernel.org> <20220304163027.29357-1-pali@kernel.org>
 <87k0d2i0mr.fsf@BL-laptop> <20220310100943.m33wsynnvexw7dts@pali>
In-Reply-To: <20220310100943.m33wsynnvexw7dts@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Mar 2022 11:22:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Q5fVUMKHz=co0_D5suLBk0rCyGKz3g854fv-HS=G3Sw@mail.gmail.com>
Message-ID: <CAK8P3a2Q5fVUMKHz=co0_D5suLBk0rCyGKz3g854fv-HS=G3Sw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: marvell: armada-37xx: Remap IO space to
 bus address 0x0
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:LsqPPnF2NqYT+HCn/WxUM2xDTIRHtIUfWHtTD+HYJNy9Lfc0I/F
 23o5f8eIEYMd3wyB+SZRMVfHNpO4liPnR9iDfn4fMj7TpwaZbnx5fjLXkVis0CxBIeoeyrw
 erKeMYmtNviUl9clm5qjdnov9KtOPR3kP9N5bPaHHQ+5WvRdzbs8Uy46wf0Aqy12EpSCWK+
 xQrGPq/1Eg5RCD4WSWXCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MbM7L/U2710=:0QUyu6z+oUBg/7/NyjV3Ka
 77gxg5U4ti46UUsXJmW1SJE7/gO9c5hg2UdN1eBAC0HgTO7ufRqBsWmwMhcdEobKiwdbBwWO6
 hLp53dFZlOjizEKOFc8+9fy9JrQFAGIfX5WqyIYdg47JWQiV+B9wTBKcFImt/GPBQTaD4yE6B
 NIiQFzTmjdFNwYbOqoJblzc9XSLlJCKjJDRk+RxfB1CwoveX9j6FQVGlr6D53gu9mo3G7VA6T
 WJlSLejdkRr1ngu1faALQouLC1xiSZ14PEuKr22ZOw9HzBQqBsWnFLyBry1QqaIZW7mWMXTDE
 tm0y9ghcHmZWGgJgBUi8AuGniCITqzct1IPDwkxOniuEkqjFjREprXcN171tkY5uGMNyLngxf
 g5/un9Zf2wzmdMw7m4mJMATEduULCj/ktTf+Pmq0DermXkjCv2yyW2EtKiehunaSwnI6NelDc
 1/t34+6ynU/fS1PWmbSQ7JGTetOT+3c/Rcfb/JV/a8e4a/gqRkh3gKkx+SnWdyCtsRpa1wh6H
 1+/e4yXV341aUtu2UOn2DuYI8oVmuDFg75LXEZ5o8r7q6Jno5ih9onbdjVngAZJJMkr23wy2/
 3JZBS7TfV2bQ/XwLRqpFlFnLnwQviPuOWzhcu/RRn4i24631tANeRDAZmUQOm+REdCJFG1ny/
 V9nKjptoeWHWk5A8P8VlCltzeZYCKCqeD+0AtTAqhU6ZVFDPiqzmD3O43fvzCz03zFnw625CE
 jlpmMmk2K3sOvLSSow1f1m+IbPmMtGcRw/XSCyBfPCsYgsP2mTFqqFsSANDg9z1NMQGSSVdpB
 Mu2vzT1NjUEswMhwMTDgkdFYEbki+1fm5EG+xvrUCaM6hJVlYo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:09 AM Pali Rohár <pali@kernel.org> wrote:
> On Thursday 10 March 2022 11:05:00 Gregory CLEMENT wrote:

> >
> > This patch has been refused by Arnd so I removed it from the mvebu/fixes
> > branch so you should not apply anything on top of it.
>
> Ok, so what is wrong with a change which increase size of IO space to 1 MB?

It should not cause any harm, but there is really no point in this if no known
devices use more than a few bytes, and Linux only maps the first 64KB of
the I/O space for each host bridge. I don't actually see where we limit the
size to 64KB, so maybe that changed recently.

        Arnd
