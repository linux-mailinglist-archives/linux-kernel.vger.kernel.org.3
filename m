Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5494FFD05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiDMRpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiDMRpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:45:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571086C4A6;
        Wed, 13 Apr 2022 10:43:07 -0700 (PDT)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBUuP-1nnnHy2BTD-00Cy3q; Wed, 13 Apr 2022 19:43:05 +0200
Received: by mail-wr1-f47.google.com with SMTP id c10so3712080wrb.1;
        Wed, 13 Apr 2022 10:43:05 -0700 (PDT)
X-Gm-Message-State: AOAM531Pa3uVn4WMC38HjZJURmqBWj+1GlNMwZVd/06vLDa1s9FG4II9
        0DfS2LJNWUtZfrs9RGY0N7sy9p6uM3yRC8IF3Qc=
X-Google-Smtp-Source: ABdhPJwTUE1CE1xfami64nFxBY7+IIS64y7rS3jabcIASkKRHKk+Nf5tIYFMb4NymZGjoQlwLVGYUtEMmpOOrUBmG38=
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id
 g3-20020a5d6983000000b00207a226df4bmr40871wru.192.1649871785202; Wed, 13 Apr
 2022 10:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com> <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com> <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com> <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com> <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
 <PH0PR84MB17186189F5025374AA39584D88E19@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a2b+ESAAkc=_2hqx0kOxwYVS6mNjMGBKhhipaSj_5jV9g@mail.gmail.com>
 <PH0PR84MB17182115D57EF6032782659C88E09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1Cc+2oY9djdp11PuOW+TBQ0zf+p8QaDY3aerk1QqaG-g@mail.gmail.com>
 <PH0PR84MB1718925AA3C8FA998C486D7C88E59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a3RSST6yvv8Oy13RFd6eZ6cS5yX9TOuK6wxXKUO-qdQ=Q@mail.gmail.com>
 <PH0PR84MB1718C7447207BF210FBB477788E49@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a3jr-FkyxLff2cK4=X-4AShnKkeYMRKsvUg=2W0bTviiQ@mail.gmail.com> <PH0PR84MB171896DE1EFA3B25A74ADED488EC9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB171896DE1EFA3B25A74ADED488EC9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Apr 2022 19:42:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1_97b14=wbYrFodRLBq_2o2gOOjk2zORp3DLG72O229w@mail.gmail.com>
Message-ID: <CAK8P3a1_97b14=wbYrFodRLBq_2o2gOOjk2zORp3DLG72O229w@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jxcoTjn01URIiVEEhLPfsXgArq1ConLprIcM4i0gpiTvj8cTmor
 JsHlLtSXTZ/fz7CTJaukks3jc60R/GzOmHPxvMw++Cy865sYEopHegLmo1GGUzy928aejGH
 OWUZZbW2lzX2GuVi5/sjMqZ/DajXfjgfnMmm4RztR2cRHhdz0xBMzhgy3uh5jJ2jHBQY0Rp
 bkKJUnEuh70cFiWeb3CMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jwe46IJ+KU8=:HzouoDV4WcrvPxZ2J9F8jO
 KEbth+eIkB8xkGr01cD2PrSIr/nt6fzrygHK6nhsSuxvv5wSUFeQiAjhmq3jVV7PEZsBPrTIE
 KkbyKjwbuCkjJQlE0QxpfP1Ymm6LiAbqLgZAMkEePOp3mse+LnS+XlKC/Zhn5lxUOUudqKWs/
 M2gH9RBnQWppPcamJNKRyicn5Fv8I2jRezlFdVxaFEEq+4+i1azLAzeh9JvaNvVCgBsvtgz1Z
 2R/EDC3P8FLmUwBXND9GiaOMLEZyufcblQGqGzvFMxQQ+EPdLmAig/Ja7pPyuej8d+JRmlI+A
 L+x8OYtBPvAq46Z+kAe+SUuETk06cdfzwlbgv67vk6Q5V6jppJs/cZPUI/8FPdgjs31vdV7+P
 k+3bx6xaXTWiGVaC7lTw+kFtcc635ODGsmOnKKISGI2UoaKxjzfXud1mFebzkR69r7NwP+Tr6
 gIRK9ckRp9zpKAgGxF++Ks4CdVb/asmmGaPq6meaH0CZG0aT6w/E4uRFIJKdoBggflnHWSPsj
 EO+TbV6jTgD4O24Z3Zs1kTVpNluyIgoeoqmUR/lALAPBiCCI8NKOGS2s1zB3qM2fmdMeGJGHN
 ntDT983wmu6WPUGulEycRPcJ/GmaBFqQQlEG1vGtCk94Tn+9kjPOaLZe7BtgvylCOoWGtYiwg
 eofAzelAaVo06e1jbo1lMRTvQRbPza60564uZ+F09Cb7byQXybnKT/P1+skghGUhYmWU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 6:48 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> > I would count passing a register address to the child device as a private interface.
> > It's a minimalistic one, but that is not a bad thing here.
>
> Thank you. Now that the parent/child issue with timer/watchdog is resolved I am now
> having an issue trying to access "iopclk" from "gxp-timer". I have tried use of
>  of_clk_get_by_name and of_clk_get which both fail to find the clock.
> Is it because clocks is outside of the axi -> ahb hierarchy?

No, that should work, but you have to pass the right device node, which would
correspond to the parent device. You should also be able to pass the parent
device pointer (i.e. linux device, not device_node) and use clk_get().

        Arnd
