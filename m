Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702E15AF071
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiIFQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiIFQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:32:24 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBE8205F9;
        Tue,  6 Sep 2022 09:05:46 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286BDcRG017117;
        Tue, 6 Sep 2022 09:05:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=SSD21BThDpWyFFFZ+RKCG44aWKEMIrCsNdZUKfNCaJg=;
 b=YZj7cRJ3nGxwFJsOYKY5XH0ZA80qXtyivaGaxrRo32t77s0FSZ1ir0lTXZSl2+HyOT9g
 NWXRzRyTOq6hksJ1fpYNl7lTpk4nDEHt0HqZCtpj0ck2PBPPySfvx8/pqceNgcf7dtOy
 bGg4iic8+Dw3KVtT829KqJMlDuD108CnI1kbdfwnNmlqsTRW/q5kEEaigz9XNfGyxVxI
 f2+r5I9C9o7iMzQ7CrvMyrgQubGENmMxaG5M/uZggLSMD1kLB1702M9ZgyLt/KfB8OOp
 oazfsM/ynOFKvW+B9sgAoz6FX/VPTltdGLDQfxYPx3JSq88JNHBZpIW1C4g5ZI+svLyP oA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jc6ept2k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 09:05:42 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 6 Sep
 2022 09:05:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 6 Sep 2022 09:05:40 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id A26203F704F;
        Tue,  6 Sep 2022 09:05:40 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 286G5cU0016719;
        Tue, 6 Sep 2022 09:05:38 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Tue, 6 Sep 2022 09:05:38 -0700
From:   Arun Easi <aeasi@marvell.com>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>
Subject: Re: [EXT] build failure of next-20220906 due to 8bfc149ba24c ("scsi:
 qla2xxx: Enhance driver tracing with separate tunable and more")
In-Reply-To: <YxdZ/9XOsWilvVSd@debian>
Message-ID: <44fe9ca0-e1d7-1e4f-9fd8-0f48a84dca72@marvell.com>
References: <YxdZ/9XOsWilvVSd@debian>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="1879738122-875352785-1662480340=:17437"
X-Proofpoint-ORIG-GUID: 5JcVUa3x1en7KPTB0xq_e_loM5Aka06J
X-Proofpoint-GUID: 5JcVUa3x1en7KPTB0xq_e_loM5Aka06J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1879738122-875352785-1662480340=:17437
Content-Type: text/plain; charset="US-ASCII"

Hi Sudip,

On Tue, 6 Sep 2022, 7:32am, Sudip Mukherjee (Codethink) wrote:

> External Email
> 
> ----------------------------------------------------------------------
> Hi All,
> 
> The builds of loongarch loongson3_defconfig have failed to build
> next-20220906 with the error:
> 
> drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_init':
> drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'? [-Werror=implicit-function-declaration]
>  2854 |         qla_trc_array = trace_array_get_by_name("qla2xxx");
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~
>       |                         trace_array_set_clr_event
> 
> drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_uninit':
> drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function 'trace_array_put' [-Werror=implicit-function-declaration]
>  2869 |         trace_array_put(qla_trc_array);
>       |         ^~~~~~~~~~~~~~~
> 
> 
> git bisect pointed to 8bfc149ba24c ("scsi: qla2xxx: Enhance driver tracing with separate tunable and more").
> 
> I will be happy to test any patch or provide any extra log if needed.
> 
> 

This looks like is happening due to CONFIG_TRACING not being enabled (same 
as what kernel test bot reported). Could you try out the fix attached?

@Steven, please see the patch attached. Do you think the fix belongs 
better in linux/trace.h ?

Regards,
-Arun
--1879738122-875352785-1662480340=:17437
Content-Type: text/plain; charset="US-ASCII";
	name="0001-fixup-qla2xxx-Enhance-driver-tracing-with-separate-t.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <ca92e75f-12ed-0867-418f-7fdbb4702c48@marvell.com>
Content-Description: 
Content-Disposition: attachment;
	filename="0001-fixup-qla2xxx-Enhance-driver-tracing-with-separate-t.patch"

RnJvbSBhZTQ2MDM3MTJjOWYzYTQ5ZDY3MDE1ZjYzODZjNTIwYTc3MzE5ZmZh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogQXJ1biBFYXNpIDxh
ZWFzaUBtYXJ2ZWxsLmNvbT4NCkRhdGU6IEZyaSwgMiBTZXAgMjAyMiAxNzo1
MzozMCAtMDcwMA0KU3ViamVjdDogW1BBVENIXSBmaXh1cCEgcWxhMnh4eDog
RW5oYW5jZSBkcml2ZXIgdHJhY2luZyB3aXRoIHNlcGFyYXRlIHR1bmFibGUN
CiBhbmQgbW9yZQ0KDQpGaXggdGhpcyBjb21waWxhdGlvbiBlcnJvciBzZWVu
IHdoZW4gQ09ORklHX1RSQUNJTkcgaXMgbm90IGVuYWJsZWQ6DQoNCmRyaXZl
cnMvc2NzaS9xbGEyeHh4L3FsYV9vcy5jOiBJbiBmdW5jdGlvbiAncWxhX3Ry
YWNlX2luaXQnOg0KZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX29zLmM6Mjg1
NDoyNTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
DQondHJhY2VfYXJyYXlfZ2V0X2J5X25hbWUnOyBkaWQgeW91IG1lYW4gJ3Ry
YWNlX2FycmF5X3NldF9jbHJfZXZlbnQnPw0KWy1XZXJyb3I9aW1wbGljaXQt
ZnVuY3Rpb24tZGVjbGFyYXRpb25dDQogMjg1NCB8ICAgICAgICAgcWxhX3Ry
Y19hcnJheSA9IHRyYWNlX2FycmF5X2dldF9ieV9uYW1lKCJxbGEyeHh4Iik7
DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
IHRyYWNlX2FycmF5X3NldF9jbHJfZXZlbnQNCg0KZHJpdmVycy9zY3NpL3Fs
YTJ4eHgvcWxhX29zLmM6IEluIGZ1bmN0aW9uICdxbGFfdHJhY2VfdW5pbml0
JzoNCmRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9vcy5jOjI4Njk6OTogZXJy
b3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uDQondHJhY2Vf
YXJyYXlfcHV0JyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJh
dGlvbl0NCiAyODY5IHwgICAgICAgICB0cmFjZV9hcnJheV9wdXQocWxhX3Ry
Y19hcnJheSk7DQogICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+DQoN
ClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9kZWYuaCB8IDcg
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9kZWYuaCBi
L2RyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9kZWYuaA0KaW5kZXggM2VjNmEy
MDA5NDJlLi5kMGRhNzM3ZTUxZTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Nj
c2kvcWxhMnh4eC9xbGFfZGVmLmgNCisrKyBiL2RyaXZlcnMvc2NzaS9xbGEy
eHh4L3FsYV9kZWYuaA0KQEAgLTM1LDYgKzM1LDEzIEBADQogDQogI2luY2x1
ZGUgPHVhcGkvc2NzaS9mYy9mY19lbHMuaD4NCiANCisjaWZuZGVmIENPTkZJ
R19UUkFDSU5HDQorI2lmbmRlZiB0cmFjZV9hcnJheV9nZXRfYnlfbmFtZQ0K
KyNkZWZpbmUgdHJhY2VfYXJyYXlfZ2V0X2J5X25hbWUoX3RyY19hcnIpCU5V
TEwNCisjZGVmaW5lIHRyYWNlX2FycmF5X3B1dChfdHJjX2FycikNCisjZW5k
aWYgLyogdHJhY2VfYXJyYXlfZ2V0X2J5X25hbWUgKi8NCisjZW5kaWYgLyog
Q09ORklHX1RSQUNJTkcgKi8NCisNCiAvKiBCaWcgZW5kaWFuIEZpYnJlIENo
YW5uZWwgU19JRCAoc291cmNlIElEKSBvciBEX0lEIChkZXN0aW5hdGlvbiBJ
RCkuICovDQogdHlwZWRlZiBzdHJ1Y3Qgew0KIAl1aW50OF90IGRvbWFpbjsN
Ci0tIA0KMi4yNy4wDQoNCg==

--1879738122-875352785-1662480340=:17437--
