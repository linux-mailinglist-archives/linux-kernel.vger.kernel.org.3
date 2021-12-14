Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB347411D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhLNLIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:08:37 -0500
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:51493 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLNLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1639480115;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5EAFu/HMn9FrEeyNoroT7Pt3sVrE+2Ra3fLKi5vt3OY=;
  b=SI7kJzL7MxZoGsgLw5e5VLnbhqSDps4KPujQRoSmziA5yYnHXzPYtcQh
   zyyPQZS/BOH5EotBYZsJKhO90unBJmjRmirkcVesXYcbJ6CMg3BkRiYS3
   7tQVaT2MPC1C8rfI6E7mjWfuRL248GJsgqw1lhV0YNPcR2bj6IIvoYiF3
   A=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: B8Z1VmTAJwOsifiTBGGNYVhTDSDM+MiSB/GML7aO9RqIUVPhBdPrfQ9qWqxmy2ADGVbP2Xb5Bw
 whNArWDYilhGr7pwMwRXsi1V6+Tgl8+uLQ8pb8IQ3928wZ1K2zhXpiPffb40UlR5CZ/j/G/i3p
 OeyVQRiEaabDaBxjLNGnJSdTR9OklxVIHP3VRsRYqJM63el5/P9bwLePTYWy/KSpJ2krLdwtt6
 T6Xpbbbd5em52TTHkBrmPTAS6mUP6dSpSvrnEFDpCxMPDABINNysZB4qmVv8XSTjYUyDl5B6Yn
 bsZ5mtz5NjWiUB/SMicZpHnk
X-SBRS: 5.1
X-MesageID: 62039465
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:Azrtmq7Cgv7AyYhnYhMirQxRtDHBchMFZxGqfqrLsTDasY5as4F+v
 jEZCDuHO/iJazamL4p3b9/koRhUucDWydVkQFdk/ikyHi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuV3zyIQUBUjclkfJKlYAL/En03FV8MpBsJ00o5wrdj29Iw27BVPivW0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pGTU2FFFPqQ5E8IwKPb
 72rIIdVXI/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8CbP2lS2Pc0MC9qZzu1c99Zx
 tlUjs2SeFYTJYLIhvQnDUhXIzFPBPgTkFPHCSDXXc27ykTHdz3nwul0DVFwNoodkgp1KTgQr
 7pCcmlLN03dwbLtqF64YrAEasALNs7kMZlZonh95TrYEewnUdbIRKCiCdpwgm1o3ZESQ6u2i
 8wxRR1ybU7yfBx2ZFoLDsIGh7uSmyjBbGgNwL6SjfVuuDWCpOBr65DpMdzIapmAQcJenW6Gq
 W/cuWf0GBcXMJqY0zXt2mKhgKrDkD32XKoWFaak7bh6jVuL3GsRBRYKE1yhrpGRiUOkXd9bb
 k4d/CsyqrIp3FKkQ8O7XBCipnOA+BkGVLJ4F+w89RHIyafO5QudLnYLQyQHa9E8ssIyAzsw2
 TehlsPjAjFHs7CPT3+ZsLuXxRu4PjIUNikFfjMeShUe4MjLp5s6hRbCCN1kFcadhd3vGCrsx
 CiKoW48jrQXicMX/7qy+1nLhDXqqIKhZhUu+gzdU2ah7wV4TI2ofYql7R7c9/koBISWVF6ap
 1AfhtOTqusJCPmweDelGbtXWuvzvrDcbWOa0QUH84QdGyqF9XK6RtFy0WBEP2htLNY+J27mU
 F/igFYEjHNMB0eCYahyaoO3Ls0ly6n8CNjoPszpgspyjotZL1Heonw3DaKE9yW0yRV3z/ljU
 XuOWZ/0VS5yNEhx8Nahqw7xO5cPzzt2+27cTIuTI/+PgevHPy79pVvo3TKzggEFAEGs/FW9H
 zV3bZLiJ/BjvAvWOHa/HWk7dw9iEJTDLcqqw/G7j8baSuacJEkvCuXK3ZQqcJF/kqJem4/gp
 y/mCxMCkQKi2yKWeW1mj0yPjpu1Av6TSlphYkQR0auAgSB/Me5DEo9BH3fIQVXX3LM6lqMlJ
 xX0U86BHu5OWlz6F8c1NvHAQHhZXE3z32qmZnP9CBBmJsIIb1GYorfMI1q0nAFTX3XfiCfLi
 +D5vu8tacFYHFoK4Qe/QK/H8m5dSlBBwr8vBBWRfYEIEKgumaAzQxHMYjYMC5hkAT3IxyeA1
 hbQBhEdpOLXpJQy/sWPjqeBx7pF2cMndqaDN2WEv7uwKwfA+W+vnd1JXOqSJGiPX2Lo4qSyI
 +5SyqikYvEAmV9Ltat6Eqpqkv1it4e++ecCw1Q2BmjPYnSqFqhkfiuM0/5Qu/Af3bReowa3B
 B6Co4EIJbWTNcr5O1cNPw55PP+b3PQZl2CKv/Q4KUn3/gFt+7+DXRkANhWAknUFfrB0LJkk0
 aEqv8tPs16zjR8jM9CniCFI9jvTcixcAvt/7pxDWd3lkAsmzF1GcKfwMC6u7cHdcchIP2krP
 iSQ2PjIiYNDyxeQaHE0D3XMg7ZQ3MxcpBBQwVYeDF2Vgd6Z1OQv1Rhc/DlrHARYyhJLj7B6N
 mRxbhAnIKyP+3FjhdRZXnDqEAZEXUXL9kv0wloPtWvYU0j3CTCdcDxjYb6ArBID7mZRXjlH5
 7XJmm/qXAHjcNz1wiZvC1VurObuTIAp+wDP8Cx98x9pw3XujeLZv5KT
IronPort-HdrOrdr: A9a23:qxryUqAY2aqKuKTlHeg2sceALOsnbusQ8zAXPh9KJyC9I/b2qy
 nxppgmPH/P6Ar4WBkb6La90Y27MA7hHPlOkPUs1NaZLXPbUQ6TTb2KgrGSpgEIdxeOktK1kJ
 0QDJSWa+eAfWSS7/yKmDVQeuxIqLLsndHK9IXjJjVWPHpXgslbnnZE422gYzRLrWd9dP0E/M
 323Ls4m9PsQwVcUu2LQl0+G8TTrdzCk5zrJTYAGh4c8QGLyRel8qTzHRS01goXF2on+8ZvzU
 H11yjCoomzufCyzRHRk0fV8pRtgdPkjv9OHtaFhMQ5IijlziyoeINicbufuy1dmpDj1H8a1P
 335zswNcV67H3cOkmzvBvWwgHllA0j7nfzoGXoyEfLkIjcfnYXGsBBjYVWfl/y8Ew7puxx16
 pNwiawq4dXJQmoplW92/H4EzVR0makq3srluAey1ZFV5EFVbNXpYsDuGtIDZY7Gj7g4oxPKp
 ghMCjl3ocUTbqmVQGagoE2q+bcG0jbXy32DXTqg/blkwS/xxtCvg8lLM92pAZ3yHtycegC2w
 3+CNUbqFh5dL5gUUtMPpZzfSKJMB25ffvtChPbHb21LtBNB5ryw6SHlIndotvaPqA18A==
X-IronPort-AV: E=Sophos;i="5.88,205,1635220800"; 
   d="scan'208";a="62039465"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuYPJW8sdJpKXA0L1MuvjnJNJ9cdc0i3elUUcWC920hUpT4DXgE06ZOSCT5QJoe+hbBKzRz3QriGuAn815QUk+az/7nk6Q26TYvgY/5623Z66RtrrLZdZ+tRDd+Mfke+lPZNx/kD2xZTM/vh6Z42qoMJ9t5FiNqbUMtquw+MnYzuzjDgBhxcWNZ/Qj1ZznfFD99Tfu/ojeIk4ykj5jUHospylDFRX0dSzE3g0cmWdWBV7p3LeUJWr3qNLvjqEzLmAaqkQ+V7rALEWgrzst+5cUqIlonJ2VdKvQjnhgAVmA27ifH7U1SZk9MW7QfEJB8QfriI/uDYz8Sl62Dy4XO02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73NJWetcVUrSo6Bba6C96xaPBU2yixLWFWq42EYFVtE=;
 b=mZwzQ80avLBZvllUUK8cAIORSfk19ahN9QlrTrryelBUbfkT3fz7GBHjNiQtSWutdYyX1YPffKrLEWPxc2cd1kWi+AUd3ukM+viNsHzoi9jooDB/zuI4la8nD7cquxBy7UXN6rJotr7iISIgkl0UXmkHG07/pC1EGDi9X5cR7as5a1l09PC1MOXk0uwmhxDZ+mv3jgWA5Ik3i2njmDiqJ0hlKrwq9W/skXWUMeCldT6Otr3agYwCDVgcYysITX1BJHfjd4CDiKUVWkIiJwbfhQ+nV70wBuoofkMq+9ZeaTj8FnYpyDp944QTZo6sw9ZWkB3YA56IFdpmWB7VN+oiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73NJWetcVUrSo6Bba6C96xaPBU2yixLWFWq42EYFVtE=;
 b=mV10h1P0LAKaxTwnLQAch/+xu47AfySrX1wXTyqsvSVI5d9d0Thkq16Udpgfjg2iGdFtSL3n7Z2XeEWgM7EFylwWORfHcR4hZUd5PUU2+DO4+/H4QX92iNZKw37zvxris2VAgHkV8VMzYG7V92nJcClgjP4FPPr3oRlB5+0b7VA=
Date:   Tue, 14 Dec 2021 12:08:26 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>, <axboe@kernel.dk>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] xen-blkfront: Use the bitmap API when applicable
Message-ID: <Ybh7KgtQt0/MFtyw@Air-de-Roger>
References: <d6f31db1d2542e1b4ba66d4cea80d3891678aa5a.1638476031.git.christophe.jaillet@wanadoo.fr>
 <Ybh5G2ziyRXkz3WF@Air-de-Roger>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ybh5G2ziyRXkz3WF@Air-de-Roger>
X-ClientProxiedBy: MR2P264CA0160.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::23) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35627b30-57d5-4ce5-1c5d-08d9bef2102d
X-MS-TrafficTypeDiagnostic: DM6PR03MB4971:EE_
X-Microsoft-Antispam-PRVS: <DM6PR03MB497102200AC5DD8776A863DE8F759@DM6PR03MB4971.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzCS+4iQlwBnB+Ly3nHX84Mx0FJQlLWb+/rCdUKj1dkeYxOFqIUvPA4sV8EvRgQ4GrUmwGyZmo6HtgLNOCDyYrfdfY5rShUn3TQ/P6pg0FPZhlVokkywyKvrPSIfgOFoXt7kNcaM95Uv0qGgsQm+F9wDdy3/AU0P0fPtnGKc1lNdfn73E3oFVm21dlOA7vqHF/M4PVDN46siAARON+soIxBc1mqI+BloN7744cUSP4jVUq+BNo7pkj4KINgdo8VCXugioDJWmY9b09m+7ydYnAfRmKY4Bs273f4di6WGbYqEF1Ux1kkfSioycx+c/C1x6L9jKQQW2Nz4T8sTp0HIb63mgUUQ9vPLzhaiz7/mzoK8jITH8CNccKYeHNSpNAIyINX+XSUuDFioqJMjsZRVlpkf6qPnJadN0/lpBWXdDU9DkhXgUI23rEnKc9L+FqIyeuxpdLNblpUIWuVlsfVzFmE31pv1nnhF/kR6UR3gdhLbdgH2q5JHSm6mwaVrdiNX7dliF9ifP+XqVlI2JntWpPo6U+LeKA52pN49e2pzKs0ARjWc+XvcEZt6U8mCcMikAU1RV/U1pi7PO01ce6Tgip0uT4u4X/GZljFCRQzaYFQfVuFaAhlAkUWLJbIoB6FpeO8DQli4vWKcabneQ3rpsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(508600001)(6862004)(6506007)(2906002)(186003)(6512007)(86362001)(6200100001)(316002)(9686003)(8676002)(26005)(33716001)(6666004)(4744005)(8936002)(66476007)(6486002)(66946007)(5660300002)(85182001)(38100700002)(66556008)(4326008)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlRpUXMxb3F6QjRqVlpMWDhjdy9qS3JiZVdNL2d3aUZrYi9oWHo2d1ZHM29l?=
 =?utf-8?B?WGhPYy8vQ0crWkVJYy9YdDhXaDh1SjY5TmFveFpFMXNWZ240dlU0Vko5SGR5?=
 =?utf-8?B?MXhxZWJ5SGFxQVRYQTVTclViZ0FEcnp4MUQwclhvakRSVFp1SUFMR2pMcVlJ?=
 =?utf-8?B?dGpiUitkZXQ3YzB1d000VGFKSlZhZk5SUUFBTWhTbGpOZGVTS1ZrWGhQYmlY?=
 =?utf-8?B?S3Z1YXRxU2lrMHBzNTgxM2lKUENQbzZSZndVSllNNy92RWVUNnRxY0JxN09l?=
 =?utf-8?B?NkFHMlJWTjZZUjJ4S3F4eUN0bGJqUHFtYUVqQTRMTVdYeDNkSFRFZHV5MzJM?=
 =?utf-8?B?VjlSWDVOZTB3V2VyNmJWTHlsNjJ2S1lCNW5NNUw2NmZFQUhFclF3K0FkNlk0?=
 =?utf-8?B?OWpadHNsbzlkc1Q3MFBEK2lpSWdBVzk0Smg4bEtqTXdLbkE3V25XTE9Tb1ZX?=
 =?utf-8?B?eEVTQStFckI3cmgwQkVTWGI5NlMxS3hCMzg2V1hYT2d5M0tvZFkrZkQ2NHRZ?=
 =?utf-8?B?ODJZM25xWEVuWm1lRFlqWGl0bXFKOUp1czEvRjJiMUlxMmV2QnVrSFZBbmh6?=
 =?utf-8?B?NTRNdzU0OTUrK1dlUDZjVDVQTEdETFdCTGlQZVdPdVN1TGJQbHF3bER3QlNo?=
 =?utf-8?B?TmluelRDVDZDSzl2YzJHVGU3aGdBK251L09la1REd1MrUm1EaTI5UUhVTTUw?=
 =?utf-8?B?OXE2bk91aFRyTlc1NGk5c3lMekZIWmhzc05NYnF1aG8zc2QzbGI0ekRWNDV3?=
 =?utf-8?B?SHlHb3R4cnZ4d3dnZ1NjMWUvUTI2bHVxSGc5TmdIelJQaHM5TTJwcW1UUSt6?=
 =?utf-8?B?OWcrbVp3TmdDWFF6TjExQkQ1YnZzUnFNR2g2cXFrd2s3aEdxZEM5LzUrRmRa?=
 =?utf-8?B?VC85QVl3ZFQ4SmdrMXVhRE5RSkQxQkVNajk4N2xsdXRRUk1Kd0ovUVppWmJw?=
 =?utf-8?B?a3FPa0E4Z0RJaEZ1dFprWlpQZW9MdHMvcnNMUDB2RmRuakhVM2xaQUtyNGI0?=
 =?utf-8?B?ZEdJVDlrWXhEc0VtRDI2ZE96V2Q3SU5JNFBDTFBNY0dRTGxhbG9VTWZoUGxO?=
 =?utf-8?B?ZEltb0ZQMUdLOGExR1c5UlB1RUs0b3JlZzk2NVIxbUxVclRzbHlTdDZpQjVF?=
 =?utf-8?B?SGQ5MkZnNFk4UlhMZGJWVTlnTjVjK21FNTFVUFFLUElZcENxdFliOHdTbHV5?=
 =?utf-8?B?clNYbzAxKzAwdXRyWFVXNFVudnF1WUM3Y2NkU3pOZXV4Ny93bVVOSWhoU0Q3?=
 =?utf-8?B?TnkxUFkyRHhpWThmMUdMYS9QaTBKaFprRk1CSGpxRkQxRGZISDQrcjZTakM1?=
 =?utf-8?B?WXFCdE81ZnNRMytuVEtWMWJuZmpLdWJtYXdIeStQUiszYU9lL1VNaTVnYWhs?=
 =?utf-8?B?ZTBuMzdnWUdoazdOKy9hZThPOWZyVU9OR01zNVlBRUp0aW9yWU5tN1RTRVM2?=
 =?utf-8?B?WWdZQmJIa05NczJVOHQxbENEZzBzRmtOZGFvaFdvbm0vK1lmWHlic0VaWDJ3?=
 =?utf-8?B?Z0tpVGRuQU9LVXZ4SXpoRFdqZCtZcFZ3ZnJUbGQrMTNvd0JqbStPSHdMbVl1?=
 =?utf-8?B?c2laQ3lPKy9NVVdJdFJ6NC80Zm1vNzlzYksrL3VXa3lZUk9heExseHk5OEQv?=
 =?utf-8?B?dUM5d3U2dE4yYTFHMkxnd3h5SUgycmhEMVlBbjloY0VhdWNaU3hNOS8vTlIw?=
 =?utf-8?B?UTcrSHhHVWw4enY1dVFnWXlUSUt0MFZzU3JPT08xTkZjNGlnTHpCQTdQTzZ2?=
 =?utf-8?B?MUh4TXZsdWhPaWxrQUNuL0pyTkVqWnVUR2ppN0ErdVFXUENkQXF4dVNWTnRw?=
 =?utf-8?B?cVFwYUVDR1A5ZS9HRWZUSXB3T3NPRERRUlhHdXdQbzl4c2xuY3d2cnFpalNz?=
 =?utf-8?B?RS8rbWxlcHBkNzYyZWxXL1IrYkpHUFByb3FGMUFhcDFqSWRmUjdETXVTbG53?=
 =?utf-8?B?SDFGWVhwdG40aXRBYXNkY29CeXdRNXF3eUJDZmxhK3VXRTd3TVNyQTNUUHRx?=
 =?utf-8?B?b1hjU2hVR2JiaUlFa0FWc1llVm9RaE5JQjJnUzFOODVyV1dSemU1OG01VFdt?=
 =?utf-8?B?NlNIZXhtbkJNeS9tN2Iyb216dEl2ZEhIKzRjN0x0dnlscWtRSm1VRFlDTEV2?=
 =?utf-8?B?Q0pwS1ozM2xzNi9uTUtFVWJMbzVzUGdHWlAwS2NPa21yOVJNNjg5czJSa2JU?=
 =?utf-8?Q?SMTkc6lbhfKijSAPEEMiers=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35627b30-57d5-4ce5-1c5d-08d9bef2102d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 11:08:31.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hl8D57BSl0OchbNbsrFFnyi0Cg8S0PwsDgXGQ19h4OF2KR182VbTnroB7x4L+oI8zs5ukrBuIVarH6gy2kZslQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4971
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:59:39AM +0100, Roger Pau Monné wrote:
> On Thu, Dec 02, 2021 at 09:16:04PM +0100, Christophe JAILLET wrote:
> > Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
> > open-coded arithmetic in allocator arguments.
> > 
> > Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> > consistency.
> > 
> > Use 'bitmap_copy()' to avoid an explicit 'memcpy()'
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Oh, I see there's been further discussion on this to avoid relying
implicitly on the size of the bitmap being rounded to the size of an
unsigned long. I think a new version is expected then?

Thanks, Roger.
