Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7C463EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhK3Ti5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:38:57 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:3446 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232989AbhK3Tiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:38:54 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUJW0Eg009015;
        Tue, 30 Nov 2021 19:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=uX3TIgoSD9/JBwbYFekuBk7vehHfGD91y40CU8no8E4=;
 b=TKGpr31geMq1wraUVPpdLjgNRxOKUCEzsv7AW4CZfisOJs7daDR6H07CjjXT5F5+Sskq
 QCSBhF4sSXI/+0Ih9kyqc5vSabbktfAs7wc51YPTyBTXdw4SB22hzODyDY1I5sVxqivx
 quxtQYQ+QRIlrLngeB/U3mW2EbuuISUyGmIPskgugtmqwrk7snJi0d1q3/473uCw54er
 IQqJM8z/G2ReVxUKwjzTHHkg6OTFUL8vGhonGsENqSHmHcZhcSziMAA7X9Sk9GkWcyRJ
 dE0csticfX+W4XjYeV1gz/wxtpcITxkFLQwDJIJhYeutB2Wku/9UFGDfarDZeb+J6zBT 9A== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 3cncxjy5bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 19:34:29 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 46CA465;
        Tue, 30 Nov 2021 19:34:25 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.99.162.214])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id E230F3D;
        Tue, 30 Nov 2021 19:34:22 +0000 (UTC)
Date:   Tue, 30 Nov 2021 13:34:22 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: make const pointer dots a static const
 array
Message-ID: <YaZ8vtajDKUVDCne@swahl-home.5wahls.com>
References: <20211127170320.77963-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127170320.77963-1-colin.i.king@gmail.com>
X-Proofpoint-ORIG-GUID: nAk4mZy6CxvkL1DBI41uWiXK86LjwcVX
X-Proofpoint-GUID: nAk4mZy6CxvkL1DBI41uWiXK86LjwcVX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 05:03:20PM +0000, Colin Ian King wrote:
> Don't populate the const array dots on the stack

That is a misunderstanding of what the original code does.  The
original code has a constant char array (string constant) that is
placed in an initialized data section of memory, the address off which
would be assigned to the pointer "dots" on the stack -- to be clear,
stack contents would not be a full array, but a pointer to it.  Then
that pointer would be passed to the pr_info function (which boils down
to a call to printk).

Examination of the disassembly shows that the compiler actually
eliminates the creation of the pointer "dots" on the stack and just
passes the address of the string constant to the printk function.

So this change should not have any actual effect (I don't know where
you got the "shrinks object code" from), and in my humble opinion
makes the code less clear.

As such, unless there's something here I don't understand, I vote to
reject this patch.

--> Steve Wahl <steve.wahl@hpe.com>

> but make it static
> const and make the pointer an array to remove a dereference. Shrinks
> object code a few bytes too.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/x86/platform/uv/uv_nmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> index 1e9ff28bc2e0..2c69a0c30632 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -725,7 +725,7 @@ static void uv_nmi_dump_cpu_ip(int cpu, struct pt_regs *regs)
>   */
>  static void uv_nmi_dump_state_cpu(int cpu, struct pt_regs *regs)
>  {
> -	const char *dots = " ................................. ";
> +	static const char dots[] = " ................................. ";
>  
>  	if (cpu == 0)
>  		uv_nmi_dump_cpu_ip_hdr();
> -- 
> 2.33.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
