Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232B64984A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbiAXQYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:24:39 -0500
Received: from sonic311-24.consmr.mail.gq1.yahoo.com ([98.137.65.205]:39219
        "EHLO sonic311-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243680AbiAXQYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1643041471; bh=QnE0u9nJ2D7ncLMcRVk8Svkk+Us++NNlt7MPBoEY2JY=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=dWVxAdrb3kwPwxqbl3EVa7XjhCezzDFUXmhparSUbzbYlhK3citDcv60vdpQ+Lvf874SHbZdoELNFCeQfU0Oj6GCaR9wam8s+9qwUP11V1ZtBWZa4nYfE4yymZC83Ylgwy5XuAeiQnXAbPjaMJg2IQcR7+uuLdYiN+KfKeVwmeS9rCLZG0U/kSdOmZaelHOeKljXpzc1Pkzq6xbCB7J0aAEi7QzAROklSCX1bm8qMQBmWg7RcL/1vKHPeXER+jlRHthE4l1FPQytxFVgEtOLNKI4/58CKusnsANxP51BW4O5q0NAX3vFzB0HmhhKVRUAvpXuyJEbGOdOqf4OYJ0KIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643041471; bh=5JT3cpg4scwbroZ0zKqG6aNlvgJFcmMXpg0wI5cxBSK=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=bOVpjdG1ApvibXUimEnzWXxvUr7JGYjXikBUE8zT0FFTWPOCRwZZSVIvKOpY+ce+lohL2V6GXOGWj7OgzdOfYQ2o/tJeB8xannhGigRyYaHHf0qnZRIPun0bEdkOR7Ghr6TJy0b83HTr4NbgUb3w6Wl15mzoExa6amVHigkdZgrYJepGkFKIAPcmuJ6+KpoPbuR3M2+Fvxv9fvsUjOIbfziafh7ViJW8pz1WlISbFZX4VqBsG3gmQ/UjoQdllKQuN65uX/ttrlYNfziQyDuWL3ZMB9NZwQobl6Piph6fyznP2Jy3MosY7xoz286DSymW4dvamwIajkpP8tS4E5wv2A==
X-YMail-OSG: YTjd_2gVM1myRYPiZT2qDD1uSZc.k0prT7Jon6fXpxif0fQOYn1CduI033TQe00
 W7AfORaDPbQ4HZzsaeEQ_pwtmMDomAV.oXP.y5jxDm2mZJWqJt.SUl4JRZy5IdXNt3NsNhARPY1P
 DfZ7nWRkAfLgE7hThv9h9lXWnDu03RCq0.Fg3vEwfqjDt69Uvo9TUZpFToj1GDmk8vYoUhOLucQl
 KJEfsT9BOPBrp1kEuH8E.njFCdGV6pSnbCXF7T9ASeYGmaQvglxMUdwUAihV_LcN2Y4WT6zX8v8m
 7Y5OKcb8cC1DzAd_9e72pZ09LH6k8WJJsD05NVJbD5tRFup1ngs1qkfKfpfcw2uqvs5IhL0FW4Be
 UdEEsTOrsiIY5gore7UZTKZTuNgmfFwdHIFCn2GdBU.2caHt8IaV1167AcnSjs6qZNZ2A.zip9Ap
 DIkMbztu_eZdJiBIEqLeQS9CqWw69l8uNu6CPMnYi6QdBiH3ISw0qsDwSNgw90xOP9Ok.NFtV3Pu
 7.1Cz2ZfVJBlxpV7xxan8oa_4ckEJX0CC5YpKFJBdelytEywv8YnHd0QrBHFviCu00YE6pRNa3jg
 qKlNNFQ.lBijtxKC6a8u2H4cEznp7hCot05_5gEI8NxM4JhaM5QFreulzuUMza787b1Pq2D9C3Iv
 qa98a3Z2AMy0TfEW_qeUFsoOXEjuABwiuVklOAIj9qTB63IQ8smAutcxmh0dmhrOmwLhtNPpffgD
 B2E0c8D3YQk2FXjktFhHiRYUw7cRsrajojCvPreEpxYsvNwC737zJAbS0iNg9kdAkNzoethhjKZW
 TdWAYrodgcD7Re7LdnhBwWN1nxLCv82JfDHOKjTMdIRRwJDSMb16plrz1rJLl59GybXqxoi2PfuF
 I3j66X7CtLxiXJnEEf2EGmmwO.21p7SAKvyBa7XqcQNsjMqCwQCmoD0obI8ozoQ3IiAoANlwevFa
 s2fPxpb0mwiIXs0tmAyaNMGQ2RYAM6H3NYEd7p1gHVY7nbRQxsHPZLI5n4xXdg1yVrURPqRPEs2B
 sGgffKSDJFF_JlVQ9keGD7h0QpZ7qpBv5JYw9JO01F07Ha1Gpjpzx4TrWPmLRpRAlZSYT.b07lFU
 Qa7K25pg4yaujaPSHwgc7jOak48dWDo7BJeJ.YpDdXYpV1LEZfbvTBGJuY96_BD9d8FGeldbUuYn
 7.mx_1mjRf4QCRpi9097aXLp_WPinGhIL1aC3egGNQ3ZIMfMXdr.h6wHDpcOufhocY6WF_9CzUBG
 6vVwB_FIOhzNAAgjtcukvg0jaim0IOP9hhzyrj2PSkMig9pt37KAd5MFyux0rfpjXDLgBus3MmWD
 gA.j56InhWdty1rhhrjxgE73iB2CjRzaFo_S3FgrkV36Aaw9FzrHHCuEXRcWZZYDlNKnJ8CkAkdB
 rrfzCeXQwlDa5L4lsuMxCS40u3F0SAMwQwyDc0dcaWfK4ycaksBUiN2kd.GVvy9Rd9y0OzqovziZ
 ucSbM0gWOKofBITrzjt.VHx5eT3SIk.nRYtt5DEkDApNwIrtK5JsYKlVxmxYaES3cK_KWowoZ.Ge
 KcYNSg4DIugh9adc5qNYVk_nrcJrJXUsdOsF3wKpAMAeLUEUztZJ_lsOu7yrNw2KQwKIl9AgcI73
 hzUvRFwHOdWfYo33Y.O7u5AsenugBP1AgWEAdZpHxuOMq.NIFx9QS.R_y0LQ6VfSu1tvv.sY_5lt
 B.yBIn_QO7CrEAtSIokG0LL1YfEAoQYWsKHr.LmDmDVPNQ0LAh.PL_FVWT81PVjUq5e3mZKiqJqL
 _H6jA5F_fVEtjyYRoUoT7GBydfXGfpY31wzg6Fl8VMwXjlGCCik5ogsZL0RFhOIps9zA4d9FxDN9
 WFi6Rv0gDPe6PKLN6oY5EODkew6z07eksBUaagCyVftHrmlGce_9qaoo_IFn1IM4qm87nHgoZpI0
 DW6DtsheX1JWW6Es19mX2mxMg.TWq5x2CR65.LXyicBuRPfpEJEhW6qCoxy7tP_ITYpUUk3hGu6b
 uHPa3dKURnNc.vmXwPL6.uO5vxgGNDyzNG4I7D30tWuRXtwkds.6eP.sHFian817keuPFjLybkAF
 EydEfo5vsUYE0KYEEdtDawY4E3Voaaap9k0VL1gf2MTxymM.yssNvUA_Th0FUqyDLRvf6gZA0V2l
 gVWAc.VmNgTNFNFw_KmtW4xU40iGwHjX_wKXu_fbFVEILoNY5DteB9Tkkd3yhgwUvAicuvO05MPW
 LLDsIASdmRzpbta556buBBVcf4cCiRmPU5xdLiQA9y7zYgR.4dA0vDq5gJzDTfyjXvUyoVEsPtM2
 K6nS6fw--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Jan 2022 16:24:31 +0000
Received: by kubenode525.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f2f9fdeae1700c79dda6133d3f183e75;
          Mon, 24 Jan 2022 16:24:27 +0000 (UTC)
Date:   Mon, 24 Jan 2022 11:24:24 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: "blk-mq: fix tag_get wait task can't be awakened" causes hangs
To:     Laibin Qiu <qiulaibin@huawei.com>, axboe@kernel.dk,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-block@vger.kernel.org
Cc:     john.garry@huawei.com, ming.lei@redhat.com,
        martin.petersen@oracle.com, hare@suse.de,
        akpm@linux-foundation.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <1643040870.3bwvk3sis4.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1643040870.3bwvk3sis4.none.ref@localhost>
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently on torvalds master, I/O on USB flash drives started hanging=20
here:

task:systemd-udevd   state:D stack:    0 pid:  374 ppid:   347 flags:0x0000=
4000
Call Trace:
 <TASK>
 ? __schedule+0x319/0x4a0
 ? schedule+0x77/0xa0
 ? io_schedule+0x43/0x60
 ? blk_mq_get_tag+0x175/0x2b0
 ? mempool_alloc+0x33/0x170
 ? init_wait_entry+0x30/0x30
 ? __blk_mq_alloc_requests+0x1b4/0x220
 ? blk_mq_submit_bio+0x213/0x490
 ? submit_bio_noacct+0x22c/0x270
 ? xa_load+0x48/0x80
 ? mpage_readahead+0x114/0x130
 ? blkdev_fallocate+0x170/0x170
 ? read_pages+0x48/0x1d0
 ? page_cache_ra_unbounded+0xee/0x1f0
 ? force_page_cache_ra+0x68/0xc0
 ? filemap_read+0x18c/0x9a0
 ? blkdev_read_iter+0x4e/0x120
 ? vfs_read+0x265/0x2d0
 ? ksys_read+0x50/0xa0
 ? do_syscall_64+0x62/0x90
 ? do_user_addr_fault+0x271/0x3c0
 ? asm_exc_page_fault+0x8/0x30
 ? exc_page_fault+0x58/0x80
 ? entry_SYSCALL_64_after_hwframe+0x44/0xae
 </TASK>

mount(8) hangs with a similar backtrace, making the device effectively=20
unusable. It does not seem to affect NVMe or SATA attached drives. The=20
affected drive does not support UAS. I don't currently have UAS drives=20
to test with. The default I/O scheduler is set to noop.

I found that reverting 180dccb0dba4 ("blk-mq: fix tag_get wait=20
task can't be awakened") appears to resolve the issue.

Let me know what other information is needed.

Cheers,
Alex.
