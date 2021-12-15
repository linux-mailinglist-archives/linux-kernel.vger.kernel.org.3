Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979B9475546
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbhLOJgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:36:21 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34918
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236594AbhLOJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:36:20 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AaHKrP6OEBSWAU37vrR1GlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdVTrhjsk3zJVymIbUW6PM/6OYWL0co9wPo7g8EkBsJfWm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM9n9BDpC79SMljPvRG+KmYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFCtq?=
 =?us-ascii?q?piLf2dCXmQJaCYE7Q2jwPAfHk20cZzsAx+v9T2P40a1pTijzPm9luwdFJnZ22U?=
 =?us-ascii?q?wYgeKPW8AgYe0AHQnohYMWq/5eCexBTq/e70ETAfGLtxfpGEkAoOssT/eMfKWd?=
 =?us-ascii?q?P/vscIStLdhmHhvKewbeyRa9inKwLJ87gN4I3oWB70TzcALAiQIidBavQjfdc3?=
 =?us-ascii?q?TEtloVNEOzYas4xdzVidlLDbgdJN1NRD4gx9NpELFGXnyZw8Q3O4/Ntui6NnEo?=
 =?us-ascii?q?hjf73PcSTYdKQA8NYgi6lSqv91zyRKnkn2Ba3kGftHqqQu9Ly?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQe2Va6i+v+relkW2W6fLE2b/mHBQXuMji2hC?=
 =?us-ascii?q?6mlwRA09TyVXrbHJoB17726MtN9/YgBDpTntAtjifZqYz/5ICOoqU4tKPjOW3V?=
 =?us-ascii?q?dARbsKheDfKn/behEWndQtsZuIHZIOb+EYzmIWsS852mOF+hobrOVvOZrGudvj?=
X-IronPort-AV: E=Sophos;i="5.88,207,1635199200"; 
   d="scan'208";a="179375"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 10:36:18 +0100
Date:   Wed, 15 Dec 2021 10:36:17 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     =?GB2312?B?zfXH5g==?= <wangqing@vivo.com>
cc:     Nicolas Palix <nicolas.palix@imag.fr>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?GB2312?Q?Re=3A_=BB=D8=B8=B4=3A_=5BPATCH=5D_coccinelle=3A_adjust?=
 =?GB2312?Q?_the_confidence_of_fen=2Ecocci?=
In-Reply-To: <SL2PR06MB308278FAD9A0DC79F92CB580BD769@SL2PR06MB3082.apcprd06.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2112151026590.2946@hadrien>
References: <1639484373-76061-1-git-send-email-wangqing@vivo.com> <AMYAywCFE0lG630WMxnU84qe.9.1639487006485.Hmail.wangqing@vivo.com.@PGFscGluZS5ERUIuMi4yMi4zOTQuMjExMjE0MTQwMjI0MC4yNjIzQGhhZHJpZW4+>
 <SL2PR06MB308278FAD9A0DC79F92CB580BD769@SL2PR06MB3082.apcprd06.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1685345872-1639560977=:2946"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1685345872-1639560977=:2946
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 15 Dec 2021, 王擎 wrote:

>
> >> From: Wang Qing <wangqing@vivo.com>
> >>
> >> We scan by coccinelle according to the confidence value, then check for
> >> potential problems. But the accuracy of this cocci is very low,
> >> the scan results are all wrong.
> >
> >Can you give some examples of cases where the results are wrong?
> >
> For example:
> for_each_node_by_name(np, "global-utilities") {
> 	if ((of_get_property(np, "fsl,has-rstcr", NULL))) {
> 		rstcr = of_iomap(np, 0) + 0xb0;
> 		if (!rstcr) {
> 			printk (KERN_ERR "Error: reset control "
> 					"register not mapped!\n");
> 		} else {
> 			register_restart_handler(&restart_handler);
> 		}
> 		break; // break here
> 	}
> }
>
> of_node_put(np);  // Is there any problem here?

This looks quite strange.  If the loop exits normally, then there is a put
on something on which there was no get.  Is the value NULL in tihs case,
and so the of_node_put does nothing?  I guess that then there is no
problem, but it's not clear that the code is very nice either.

But I think that the real of_node_put problems are covered by another
rule, so we can drop this one, as you suggested.

julia

>
> And there are many others:
> >>>>>>>>>>>>>>>>>  iterators/fen.cocci <<<<<<<<<<<<<<<<<<<<
> drivers/edac/cell_edac.c:165:1-12: ERROR: of_node_put not needed after iterator on line 137
> arch/powerpc/platforms/powermac/udbg_adb.c:204:1-12: ERROR: of_node_put not needed after iterator on line 195
> arch/powerpc/platforms/cell/iommu.c:744:1-12: ERROR: of_node_put not needed after iterator on line 737
> arch/powerpc/kexec/file_load_64.c:1037:1-12: ERROR: of_node_put not needed after iterator on line 1023
> drivers/cpufreq/pmac64-cpufreq.c:640:1-12: ERROR: of_node_put not needed after iterator on line 501
> arch/powerpc/kexec/ranges.c:271:1-12: ERROR: of_node_put not needed after iterator on line 248
> arch/powerpc/platforms/chrp/setup.c:479:1-12: ERROR: of_node_put not needed after iterator on line 470
> arch/powerpc/platforms/chrp/setup.c:524:1-12: ERROR: of_node_put not needed after iterator on line 521
> arch/powerpc/platforms/4xx/uic.c:293:1-12: ERROR: of_node_put not needed after iterator on line 280
> arch/powerpc/mm/numa.c:1317:1-12: ERROR: of_node_put not needed after iterator on line 1289
> sound/ppc/pmac.c:970:2-13: ERROR: of_node_put not needed after iterator on line 951
> drivers/tty/serial/cpm_uart/cpm_uart_core.c:1336:1-12: ERROR: of_node_put not needed after iterator on line 1316
> arch/powerpc/sysdev/fsl_soc.c:190:1-12: ERROR: of_node_put not needed after iterator on line 177
>
> Thanks,
> Qing
>
> >thanks,
> >julia
> >
> >>
> >> So, lower its confidence to low.
> >>
> >> Signed-off-by: Wang Qing <wangqing@vivo.com>
> >> ---
> >>  scripts/coccinelle/iterators/fen.cocci | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/coccinelle/iterators/fen.cocci b/scripts/coccinelle/iterators/fen.cocci
> >> index b69f966..7b71207
> >> --- a/scripts/coccinelle/iterators/fen.cocci
> >> +++ b/scripts/coccinelle/iterators/fen.cocci
> >> @@ -2,7 +2,7 @@
> >>  /// These iterators only exit normally when the loop cursor is NULL, so there
> >>  /// is no point to call of_node_put on the final value.
> >>  ///
> >> -// Confidence: High
> >> +// Confidence: Low
> >>  // Copyright: (C) 2010-2012 Nicolas Palix.
> >>  // Copyright: (C) 2010-2012 Julia Lawall, INRIA/LIP6.
> >>  // Copyright: (C) 2010-2012 Gilles Muller, INRIA/LiP6.
> >> --
> >> 2.7.4
> >>
> >>
--8323329-1685345872-1639560977=:2946--
