Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB04E5899EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiHDJ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiHDJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:27:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A376C67C86
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:27:45 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220804092742epoutp0194ef3d310d000576c8666b40fdd9a20f~IGjGQxrZU0361103611epoutp01t
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 09:27:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220804092742epoutp0194ef3d310d000576c8666b40fdd9a20f~IGjGQxrZU0361103611epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659605262;
        bh=3lGwUKi+0s6ZPWmFI3hLZpFrre3+h5bxar8GLXVgJPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SJVf5Xsbb7ZDh7XhkZw9maoUzBhtL7ggBRWEOFesMGNc9pGSIcXFuBxNW+ev54pjD
         XSGfle3BRcmkCrAfSR+/Epyj0qupiCzlMwoIQgG4xpfG/kUoM6f9EWblfF/q/r+gmT
         fU7lxGAYe5h0fXy1Nyt6VhAvXwY2HcnfdGcu4Jac=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220804092742epcas1p20abecc3daeef587da2f2385dc23e4173~IGjFpMM6S0147201472epcas1p2H;
        Thu,  4 Aug 2022 09:27:42 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.133]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lz3Kn20Vzz4x9Ps; Thu,  4 Aug
        2022 09:27:41 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.7B.09633.D019BE26; Thu,  4 Aug 2022 18:27:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220804092740epcas1p4db7cd84005f225973819bac98dd4e32f~IGjEHrPJ20837008370epcas1p41;
        Thu,  4 Aug 2022 09:27:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220804092740epsmtrp10b3e96d665ce38373564dbd35e1ecf84~IGjEG9xU82656326563epsmtrp1v;
        Thu,  4 Aug 2022 09:27:40 +0000 (GMT)
X-AuditID: b6c32a36-075ff700000025a1-84-62eb910d92a6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.D2.08802.C019BE26; Thu,  4 Aug 2022 18:27:40 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220804092740epsmtip1c99b9c30cc69c2856ccfd44b7b438940~IGjD7_g9e3181031810epsmtip1F;
        Thu,  4 Aug 2022 09:27:40 +0000 (GMT)
Date:   Thu, 4 Aug 2022 18:27:40 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Daniel Stone <daniel@fooishbar.org>,
        Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: New subsystem for acceleration devices
Message-Id: <20220804182740.734658fd7b89c3bc50cd4c03@samsung.com>
In-Reply-To: <CAFCwf12NGpFin3fVrGs=Ca5zqAqztoY5wbyV1WD5vTpZML3LCA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTV5d34uskgwe/uSxOXF/EZPF30jF2
        iyut01ktmhevZ7O4vGsOm8WFF7dZLa48D3Bg9/j9axKjx4uv25g9ds66y+6xf+4ado9bq409
        Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvM
        AbpESaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBg
        ZApUmJCdcWTuf7aCRpmKjWfusTcwvhTtYuTkkBAwkXh4upu5i5GLQ0hgB6NE2/9TLBDOJ0aJ
        2R/vQ2U+M0o8P3CXBaZl2vs77BCJXYwSfYsXs0E4HUwSrY0H2UCqWARUJBpWN4PZbAKqEjNn
        rGEHsUUE1CWu7esBa2AW6GWSeHO5jRkkISxgLHF252+gBDsHr4CjxPMwkCinQKDEjhk72CAW
        W0jc7VnB2sXIAVQhKPF3hzBImFlAXmL72zlgh0oItHJIvF87gxGi3kVi79zHUL3CEq+Ob2GH
        sKUkXva3QdnZElM6FkE9ViBx7vlWZpD5EkDXXFyRAmIyC2hKrN+lD1GhKLHz91xGiLV8Eu++
        9rBCVPNKdLQJQZQoSSz5cxhquITE1BnfmCBsD4mt9w+xQgLqALPEzSmrmSYwKsxCeGYWkmdm
        ISxewMi8ilEstaA4Nz212LDACB69yfm5mxjByVLLbAfjpLcf9A4xMnEwHmKU4GBWEuFdYfk6
        SYg3JbGyKrUoP76oNCe1+BCjKTBiJjJLiSbnA9N1Xkm8oYmlgYmZkbGJhaGZoZI476pppxOF
        BNITS1KzU1MLUotg+pg4OKUamDxT+4OahT4tTJ2jYzg/IszkzNdm9ellJsvjiww0a55tkvkw
        h+fujP9PNpw3zuvQ2Pl9ov6EBUe29SxeuNju0rY89bBkeYbuXRMarz429DJ2mDh99asFNzZd
        uP0+dDHHmpMX589MXrt1VeCsjA+aG+28+KfeDH4rHNZ7xnVJYdbCit6/hWYhe6qcFlz5me75
        Tb/eMXTzoUuuyZ/Ui9/u0l798cQ1DydzFbZXbSYhTbd5KnvvnHDo/d1V2PF6y3X+59VpD4L8
        8zscVwlsmrR5cbNPJ59d2rKOuU2c158JqOqf7yoX/XG8J6+H59WOD/+vKbF3KbCH3uzWusvc
        MvPZasvtexjUjRZZMho1Bf7d+FuJpTgj0VCLuag4EQAFwinyHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnC7PxNdJBtuXyVmcuL6IyeLvpGPs
        Fldap7NaNC9ez2ZxedccNosLL26zWlx5HuDA7vH71yRGjxdftzF77Jx1l91j/9w17B63Vht7
        fN4kF8AWxWWTkpqTWZZapG+XwJVxZO5/toJGmYqNZ+6xNzC+FO1i5OSQEDCRmPb+DnsXIxeH
        kMAORokF554xQiQkJDbdW87cxcgBZAtLHD5cDFHTxiRxe8EWsBoWARWJhtXNbCA2m4CqxMwZ
        a9hBbBEBdYlr+3rYQBqYBXqZJE4tucwCkhAWMJY4u/M3UIKdg1fAUeJ5GEiUUyBQYseMHWwQ
        8w8wS9ycspoJ4gYLibs9K1hBbuAVEJT4u0MYJMwsoCXx8NctFghbXmL72znMExgFZyFUzUJS
        NQtJ1QJG5lWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFxoKW1g3HPqg96hxiZOBgP
        MUpwMCuJ8K6wfJ0kxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwT
        B6dUA5OVslyQd1F43xcT1R0lu7eeWpebMulSrJbDubz8Zm9lrqAM8Wl/k1xyTfuj1eZHZZYY
        Fk76lW52R72g37UvIuq9LpOl1JkJuiWT65o42M4GnJ1Vk6t3Wcf7w80XtV7PZ3f0sE+evSDg
        dtfFhxyxrnM6WlrUMx8J6XY0bloS+sl+1svntZ3veM8sYPh502ahSxxDVmiQqoH92xanj7y8
        RX+1mnWiWHgqTpYriS2+vKj71lXx3X8K1PwXOp8RE48+Zvfuh4bEca3yY3UbnpTwS/+fnaIy
        26/V8Hzg3pkHGt1jTV4f5ozc2/vv7kFfjl3JJet4Y8JlzOYGtt9d2DafreUr445Hvu1NU+vq
        n/kpsRRnJBpqMRcVJwIAGzgn7fICAAA=
X-CMS-MailID: 20220804092740epcas1p4db7cd84005f225973819bac98dd4e32f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220804064719epcas1p2ba6291b7204495ffb46e2d2c6988fdea
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
        <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
        <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
        <CAPj87rMSNtqZUbH_5rmGAXpWONKhoZHJsjbw11PwYwXJi0b9jA@mail.gmail.com>
        <CGME20220804064719epcas1p2ba6291b7204495ffb46e2d2c6988fdea@epcas1p2.samsung.com>
        <CAFCwf12NGpFin3fVrGs=Ca5zqAqztoY5wbyV1WD5vTpZML3LCA@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 09:46:49 +0300
Oded Gabbay <oded.gabbay@gmail.com> wrote:

> On Thu, Aug 4, 2022 at 2:32 AM Daniel Stone <daniel@fooishbar.org> wrote:
> >
> > Hi Oded,
> >
> > On Wed, 3 Aug 2022 at 21:21, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > The reason it happened now is because I saw two drivers, which are
> > > doing h/w acceleration for AI, trying to be accepted to the misc
> > > subsystem.
> >
> > Why misc?
> You will need to ask them ;)
> Seriously, I guess they thought they were not gpu drivers and didn't
> find anything else to go to.
> And at least for one of them, I remember Greg and Arnd pointing them to misc.
> 

Hi, Daniel.
Samsung NPU driver is one of the trier to be a misc device. There is some
reasons that it chooses misc, but it can be simply said that GPU was not a
perfect suit for NPU.
AI workload is not limited in graphical job, it can be NLP, data analysis or
training job. The GPU/DRM can work for them, but its description is not for
them.
e.g. AI workloads needs to manage ai model data as well as input data. I guess
it can be working with GEM object, and needs to be expaned for model information.
But I have a question that DRM accept this specialized GEM, thus it's not
related to Graphics.
Other subsystem was simliar, so I only could choose misc device.

IMHO, at the same reason, I'm positive on Oded's working, expecting that the
new subsystem could be more specialized for AI workload.

thanks,
Jiho

> >
> > > Regarding the open source userspace rules in drm - yes, I think your
> > > rules are too limiting for the relatively young AI scene, and I saw at
> > > the 2021 kernel summit that other people from the kernel community
> > > think that as well.
> > > But that's not the main reason, or even a reason at all for doing
> > > this. After all, at least for habana, we open-sourced our compiler and
> > > a runtime library. And Greg also asked those two drivers if they have
> > > matching open-sourced user-space code.
> > >
> > > And a final reason is that I thought this can also help in somewhat
> > > reducing the workload on Greg. I saw in the last kernel summit there
> > > was a concern about bringing more people to be kernel maintainers so I
> > > thought this is a step in the right direction.
> >
> > Can you please explain what the reason is here?
> >
> > Everything you have described - uniform device enumeration, common job
> > description, memory management helpers, unique job submission format,
> > etc - applies exactly to DRM. If open userspace is not a requirement,
> > and bypassing Greg's manual merging is a requirement, then I don't see
> > what the difference is between DRM and this new bespoke subsystem. It
> > would be great to have these differences enumerated in email as well
> > as in kerneldoc.
> I don't think preparing such a list at this point is relevant, because
> I don't have a full-featured subsystem ready, which I can take and
> list all its features and compare it with drm.
> I have a beginning of a subsystem, with very minimal common code, and
> I planned for it to grow with time and with the relevant participants.
> 
> And regarding the serspace issue, I believe it will be less stringent
> than in drm.
> For example, afaik in drm you must upstream your LLVM fork to the
> mainline LLVM tree. This is something that is really a heavy-lifting
> task for most, if not all, companies.
> So this is a requirement I think we can forgo.
> 
> Thanks,
> Oded
> 
> >
> > Cheers,
> > Daniel
> 
