Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CAD4D6050
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348168AbiCKLDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348176AbiCKLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:02:51 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4B1BD9A1;
        Fri, 11 Mar 2022 03:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1646996508;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NZfuSuOf3HsgXGGjM3uvYPU0K7q//s5hos77iiW/mIg=;
  b=W8/fB8epR3knMSnFqwbhNSlEO6rtkoBOkbRSHWzmjN5T6j8gMHtyQUa/
   Sb/TabtzS9PBH+zCeStAsfVmWF1CXNEbFcaf7ZOlGzPAedodcgpkxpyT/
   ChScCxTn6p/Ojz7hy81eEnl5uYdliSBQSYC5OM1r3D+ZPROTEUHRmEv59
   Q=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 66009274
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:PvFD16v87McJy26zE3mMDyL8zOfnVMteMUV32f8akzHdYApBsoF/q
 tZmKT+OO/bYYTT2fNpzaIS1oEoDsMTUm4VgHFM/qyxgH38b+JbJXdiXEBz9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jU4
 IuryyHiEATNNwBcYzp8B52r8HuDjNyq0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatA88tqBb
 /TC1NmEElbxpH/BPD8HfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1he66RFxlkvgoo
 Oihu6BcRi8wIoPSnN88CiVkMDNdYO5l+4f+Kz+W5Jn7I03uKxMAwt1rBUAye4YZ5vx2ESdF8
 vlwxDIlN07ZwbjsmfTiF7cq1p9LwMrDZevzvll6yj7UF7A+SI3rSKTW/95Imjw3g6iiGN6AO
 ZJBOGAwMHwsZTUWYVocL8sCod2hlz6iVhtnunWuj7Metj27IAtZj+G2bYu9lsaxbd5Ogk+Sq
 2bC/mL4KhIXLtqSzXyC6H3EruXIhyLgHoUJCKe/6OVpkXWU3GUYDBBQXly+ydG7gEOjX9NUK
 2QP5zEj66M18SSDR8n3WBCQo3OeuBMYHdZTe8Uq5QfIxqfK7gKxAmkfUiUHeNEgrNUxRzEhy
 hmOhdyBLT5gqrqOUlqG66yZ6zi1PEA9KW4EeD9BTgYf5dTniJ88gwiJTdt5FqOxyNrvFlnYx
 zGMsTh7jbEUhs0jyaq25xbEjiiqq5yPSRQ6jjg7RUr8sFk/PtT8IdX1tx6Ltp6sMbp1UHGYo
 FYan/O/tdwyLoOuyW+uQ900FvaAsqPt3CLnvXZjGJwo9jKI8nGlfJxN7DwWGHqFIvroaheyP
 haN5Fo5CIt7eSLzMPQpO97Z59ECkPC4fekJQMw4eTanjnJZUAactB9jakeLt4wGuBh9yPpvU
 Xt3nCvFMJr7NUiF5GbnLwv++eVyrszb+Y81bcmqp/hA+eDCDEN5sZ9fbDOzghkRtctoWjn9/
 ddFLNetwB5CSuD4aSS/2ddNcQ5bdidkVciu8pI/mgu/zuxOQTBJ5xj5m+5JRmCYt/4NyregE
 o+VBie0N2YTdVWYcF7XOxiPmZvkXIplrGJTAMDfFQ3A5pTXWq72tP13X8JuJdEPrbU/pdYpH
 6htU5jRWZxnF2WYkwnxmLGg9eSOgjzw3lnQV8dkCRBiF6Ndq/vhoYa1IFGwqHFQUkJad6IW+
 tWd6+8SerJaLyxKB8fKcvO/iVS3uHkWguVpWEXUZNJUfS3RHEJCcUQdUtdfzxkwFCj+
IronPort-HdrOrdr: A9a23:3gXLcqOAfiKg+sBcTjujsMiBIKoaSvp037BK7S1MoNJuEvBw9v
 re+MjzsCWftN9/Yh4dcLy7VpVoIkmskKKdg7NhXotKNTOO0AeVxelZhrcKqAeQeREWmNQ96U
 9hGZIOdeEZDzJB/LrHCN/TKade/DGFmprY+9s31x1WPGZXgzkL1XYDNu6ceHcGIjVuNN4CO7
 e3wNFInDakcWR/VLXAOpFUN9Kz3uEijfjdEGY7OyI=
X-IronPort-AV: E=Sophos;i="5.90,173,1643691600"; 
   d="scan'208";a="66009274"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEiWyupErfhEk0a5x0tQH4FhUD58IQIcepJ9CkxWd/sxWOyhtiRXJgAjRVnmjSM9B7a/MUUj5dbplIhg29Yodxg9tOhMmCQZv5FtZ7VK3zwDQ1AyX2Afo5y8xXcalSVo7jnpGOUTQLV7OvCtjw5+ynIIxhkHfXcOrWn9VZbmoupDhxxRySyj2dXvo+LDmehUtjZOTLSxGweInJIw4tNvkoqMIlbh/R6F88DBbNcBTy0KldCVHLAehgmUsSeSRpbXpSgcRijc2Q0JhRGbxQYI+xsk0vMef7QqGiMInH6T7oOm+VS/WjAQfLbFQ9xGGEXW9D18VlPW/5HvJqSUyLccKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r+XHGjRDZfJFK8qVKqeLX5YluqIfaqF+fN63ptoViM=;
 b=kqowpKl9+jiu/D7ulcILiWQ4P1t22oT/Dm5hNdZEdxLIdp7/Znu9P72+wpKjjt0sniN0Oeu95M/NUZFO+SQkKbygZ29Vay7FyzZ2US63PRUXT2xngk3JlNXMi92capKB2OdKz4OSvx67E8CABo5k5MvSMLszxWn0duNOiu1ViiFu2tnQ7qFWGmqiRYUNYTb212ZvjimPArR6nqHIhw7vqnw+pzeMS6wBgLwVF+5mikToj0NTiqb7kMGI1xppy6c06ENz9A3Fa4bT2tGgEmeXOC2x5viy1EYsquWaGGnKm10WbEE3sa7vBorYZRyr4T0GNaTqcbftzJfofoxOA/P9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r+XHGjRDZfJFK8qVKqeLX5YluqIfaqF+fN63ptoViM=;
 b=xle8AYtbEulfowagL+mL9Sy01DQuwR7Ga8pjYm7T+5fRtaScMFj4vxnPE+7b2yXsOB30j+wS1Oje+YE1ck3z5FxnvFNMhkEOnRBmKllKo22lXHm2MFU6BXpzN7SQruLKAjmxmbkoXCN9AE5J5hvRu3tI540CCHB8D5fY/G0Cp8Q=
Date:   Fri, 11 Mar 2022 12:01:40 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Beulich <jbeulich@suse.com>
Subject: Re: [PATCH] xen/blkfront: speed up purge_persistent_grants()
Message-ID: <YissFI7k6AYkM45X@Air-de-Roger>
References: <20220311103527.12931-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220311103527.12931-1-jgross@suse.com>
X-ClientProxiedBy: MR1P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::19) To SA0PR03MB5610.namprd03.prod.outlook.com
 (2603:10b6:806:b2::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e525ee9e-8b8b-4b93-b503-08da034e8790
X-MS-TrafficTypeDiagnostic: DM5PR03MB3275:EE_
X-Microsoft-Antispam-PRVS: <DM5PR03MB32759E503A9B056FC41C99318F0C9@DM5PR03MB3275.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQn+0NUe9VX22Zmfim6tbAKg/gP4rIwMeHemgsF5YeXy6ow0Sr5+SJ+szxux9z3c20p1Mn85cbuTNbvsa54xVRxCbp3/RKBcNQrskTLbaj51HqN+NjRZ3ob/VOhGpki6OAhDYFhNudK57RBx1B4VPB2uUTfnWtQ7ujH+sthlM+ly3yp0IK7HxdmnJPxw9eDl0ezF81JyMF9R9F/H808slE6KnFN5Hixftl63CLVQMh3vn1mNl4SHgnOn1r10jF+JbZKakY/OYHMAXBJoArewilWyHyUII0C9BqDaC+CJbfQKcWHr+AtkNj4tjPsl66bxoAXBzFgDCWXX+hP1pDYC+EkpSXiIVdR5kc3VHrwg9Q7BxlYFzWxJC39YKn1pXSEHggHhT2zRdIdHgFcgrNBCwhAdejZww0rE2w2JDd650TegKmQMtCIMakiTOIx8/yftO6GrI16+SK4YoSGcSM5GLuihJ6OuhIqsor3Sl9SVEtQX2xWDEdTkq8jZ6CgtGdRnvcK5YLcId3Vt/zy1K/veVsqSTy2uGJMR0v5lZlon6TQzzJUidTmv8JYg7JD3+G/lyEW9eJ0EPImaPYjH4i46tPDtfP5wdfiRusaRLuIU3Om7qI2hnqabJkMpEa04MzQCBAACLJa1MqOx5lgM/advMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR03MB5610.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(316002)(186003)(26005)(66556008)(66946007)(6512007)(9686003)(66476007)(4326008)(2906002)(82960400001)(8676002)(6486002)(38100700002)(6506007)(508600001)(8936002)(86362001)(5660300002)(4744005)(6666004)(54906003)(6916009)(33716001)(85182001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3diL0hLQm1hQzJ5QUNxZkNOU0gvQlM0dkJncnFCSzVTNUE1YVQya2pTN2N1?=
 =?utf-8?B?Vkp0aDE0L2xIbGZRT2tkaEVac2VWSHlLN0kzVCtqdFFtTlpjZ21Ta1V2VkRw?=
 =?utf-8?B?RU8yWjB1UXdDZkg4Vm9nZUJVMncvcEl6Qi84bjZyZjducS9CS1VIMGVXcUE5?=
 =?utf-8?B?WWU4NElyendlUWQzUnQ0OXI1dWowVWFnU3lEeVZjdFdqcEluZEF2WHJxVjBq?=
 =?utf-8?B?cWtYNlJQVVVuZi96OTliWjcxSUdnMnNPRkplSGtpa3F1WTVSR0IvdUloQW0v?=
 =?utf-8?B?a3VnZCtucitkeFZrUFF3Ty9lQjhsVGZrUUYvTnB4enZFZVRBZGRDTEV6dkIr?=
 =?utf-8?B?VjZGeURoMzV2QVQyT0NXQWNTUmRSZkc0VXVOK29mbTllaTRRaXpvUG9TbldY?=
 =?utf-8?B?N3o2T3pZQ0VzOVJKZG1jdHUxT2RyVi9rdWtqQW15STRYWGdMWXVjZ0JRTUFm?=
 =?utf-8?B?V1R4dXZJOExnSG9va0gvN3dxNmVpQ2FWVTBiVHQ2T2NSakFqa1BFZEQ5dE8v?=
 =?utf-8?B?bXI1eWRKSnlDQzM4RHY5RHZOL1FGMi96Rk9DeVhDZlhIMFFSSjNGdFVER1Ba?=
 =?utf-8?B?YXZ0T1ZZeFBINGIwa24vcnhXUjRRQ0R0eElYd3U5eVdvZSt5MStRY3lNYmVt?=
 =?utf-8?B?L3lxRW9vTno1dXdlaGROWW82ZEhCYTRPQzBwTXRXR0ZMaWl5Snc4S2drQU9T?=
 =?utf-8?B?em13K2NXMWVlRWNzdVZPOEhDeEExRExISzVUM09NMWZIRXFrNjVGM1VKclg1?=
 =?utf-8?B?MnBDMWNHVHFMTmlaMmswblNoUE1MT3JrNjluYjRlWWFSMVRoOXZjTU1kZXRs?=
 =?utf-8?B?WUxKeHFGUCtlQlVDT1ZNMHFHaXB0OUFLZHJOdVRZb2NVcWdHNzVLRUtGdDMr?=
 =?utf-8?B?Rmtqa1h0bi8yb2F3S2lwWklrU1B6VEZTcGZHa1J5Q01rZk9oOTE3bUU5Tkxw?=
 =?utf-8?B?OEQ1bTNXcExKNThzWG9WMXdQYWJoc0xwM2ZOa3ZzcVdYa2ljVHVZTG4vbmJ6?=
 =?utf-8?B?Yi9OVFNtY3gwOVcyd2JZNERDWHJ3VkhwMyswSjl0WUtBQVA0NVF0N1F4Sjlq?=
 =?utf-8?B?U2pPQXNKZW9MY2dsRXRpMmpMY3c5ZXlXcEJGQUhnai9WWUtoTmxPRGFuTm5E?=
 =?utf-8?B?L1VHUFhWQXRQZGpHa0F1elN3NWN0SVM5RGNZb2REdWZiVkRycktvVVRFZDFJ?=
 =?utf-8?B?Q0dqc29jRy9EaU5IbDVKSTdFOTNZMEhWaHlvRytNSU9IYm5KdzFBc0d2Uzlh?=
 =?utf-8?B?UERsbUdGcFNaZml4bDhIU2VIbTdOUUl0Y2kwZ1ZrZTJQV2o3THJyK29INlVV?=
 =?utf-8?B?RmFTaVFyc3dXaHprRDczcDlCN1poWDBKb3E1aDA0SExtTVVwc1ZYMEdjRWQ4?=
 =?utf-8?B?cU01TkcyOENYVitvVFQzVGt0czkzeUY5Z1pzSVdlZmZjUUhrUjk1cWF0S2FP?=
 =?utf-8?B?MnFpNFNZZmdpdXgwVnVkVHFkY0NxZDhkaUN4ODVoSWUzc0ZCaHFtMit3WTZZ?=
 =?utf-8?B?OUFRVUFwbG1iNzV2bkppZ3BQMUVWYlNPWVpOVEE5SlduUXQvL2NRelRZbUdX?=
 =?utf-8?B?U1J6OFUvK2tXcmQreDczWjlWZ1lFNmNKN3hScVkyaDMrYndHeGNFS0p2aVZ5?=
 =?utf-8?B?cU5LQzY4Mnl0TVliaDc0OFNMVE8ySWJreXhUellXL3Y0dis2ajVTZGg2blNV?=
 =?utf-8?B?eHBxbjk3d2swMGlJcldmci82L0tmUDB6c3l1ZnF3ZjFEeXVwNTdLazFDSm81?=
 =?utf-8?B?QzNSUmJJL0NJUFZQeVBLeWlqMDZpbllZV1BpZHJlcVZhd0grcW9JUXpzcWh5?=
 =?utf-8?B?VkMrZ0lFdWowaHI1L2hQRjFGTm1rYWdwSTIwRGEvRmhQekhNYldIWGpoQkdL?=
 =?utf-8?B?TXRJOE5CRkJWUGR3TlNjbVY5eG9xM2YycFoxVCtVRHcwdFZicXlXbW9Oekd5?=
 =?utf-8?B?bXZudVpDSG5ybkFWOEplVi8vVVFOcHJDdGp1SnZjSmRqcjMwR3R6WW92T3V3?=
 =?utf-8?B?Zm0waDFhNEhnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e525ee9e-8b8b-4b93-b503-08da034e8790
X-MS-Exchange-CrossTenant-AuthSource: SA0PR03MB5610.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 11:01:44.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dGSxbXSyHy+HsKoFZu3IUYkMWn2J9cTJj1hZlUWN06E8m+gee8OVndEDir23tkyPpd25dr4wed6TFLA5MJQnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3275
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 11:35:27AM +0100, Juergen Gross wrote:
> purge_persistent_grants() is scanning the grants list for persistent
> grants being no longer in use by the backend. When having found such a
> grant, it will be set to "invalid" and pushed to the tail of the list.
> 
> Instead of pushing it directly to the end of the list, add it first to
> a temporary list, avoiding to scan those entries again in the main
> list traversal. After having finished the scan, append the temporary
> list to the grant list.
> 
> Suggested-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks.
