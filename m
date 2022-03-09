Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1CF4D3999
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbiCITLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiCITLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:11:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C5E142341
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:10:49 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229J69Td030956;
        Wed, 9 Mar 2022 19:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Q8pQBqpEuS6OCq05PP17wKku2KSmi9Lvr6ltXFqbuyU=;
 b=j4zcFQ/0wh9rpzGO8TEqmD4XfcgugIOJ3bvgCmXSxFPZkTwTe2wb9UK/kbvykWWKkx3U
 J/remhQkkhEDmxn6/z2aNE8Tb6nlBulf7JfaK7Uj+k97Yvsv2ftxajd5Lzw5dKnijh7V
 eD2+Tn18LtxeNmMKjwlGBNjUxcHVuj9WM1aid9Hpd49S9+EyTHMYHhirAvgZWANyajK3
 TVnxBMQ9soN/yeBlJpTs5hCvi8g3N0yF0sFQX2vYA0LpF3BF72e5cKcJPSOGaf7AfAKn
 tJ1N0VE8ILenCDmL4dR7L/ljfKwlg0jF5SRBh+lDt9Xo0VYkzgm20Kcz8JzmWGRVa+tP ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyratnyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 19:10:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229J1V52147511;
        Wed, 9 Mar 2022 19:10:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 3ekyp348m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 19:10:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCPVZlN1CeM3pfHIu+Ypb8HHA3TukCm9oSG/hPSpDPxgBGrGUxO/Atfn5Uyb4tFHR5T9IeiM/WW4m77pPaKpXngjSoCV/N1H5H+cMEyJRrd6SvQmHjmT8gL5jPFkYB9AzaSOVyqxIqfrbRKexFjgDNElYz0r5tz3C8J/3+E4VpDCBI6fGAPHYtbKjq25yyCQMRAeZe2k0vTdCvLSlgzkMqfCA/Lfmkp2cOF65bba47Oc+1J4NtVTPP2ktfLbVZHnAvctPQUWjJRaW4vFZhuiNUXLjelVUT4S5UkVLACYsxGMoe9Xc8Z1MhtCkDrp1I+VHsSMa5/Cj2ACWwo0R4ctIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8pQBqpEuS6OCq05PP17wKku2KSmi9Lvr6ltXFqbuyU=;
 b=gnmpGLR1t/4VeD031wmS5EOcp7+q9kt/UmbTNWhOgNfF/AB46Bcy4INr9WcHZVscyeSZy3nLes3G6SWDg+DLxVhOP10Sc8v8nvSF4OPgrQiHs4Gv9QPwX7qxjZodjbJAMVieEH9pA3j8tnj8YyJ/cxEcXOfq5KU1PlSz3SCCJKM+1Smzvrf1zrHv+1/yItCHMT0oKLcQCbg6jXhlkfGOfN+2A2uBUNhhHtZl7yeix5HO74LxbivpXmoIDnZbnAQrlzh3C2ltNPCEi7C5qDe6TyPXfLplYlZHYMZQpxYtJghMb560J4gvnSHCGQGLGbJDVdnPf5lJp6IA0QWJVivABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8pQBqpEuS6OCq05PP17wKku2KSmi9Lvr6ltXFqbuyU=;
 b=LMc0w1/nv0mcwRHpjeeOZgBLoykAyHDVBNsX/0waoaiigAoAxIPNJR4WB5T8x23K/SHBvaVPxRn3Gwgyp7vjoVzvCxlhuh81/KF83GukiyXcpEIiU+gUkvyDBmtk4en+e3I/UIFQYxs9HLM9PBpzIMZ+rvmscTL2tzQfz8q70pg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1483.namprd10.prod.outlook.com (2603:10b6:3:11::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 19:10:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 19:10:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Topic: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Index: AQHYL4FzWFkyFnZUSku+xBH1UQyT+KyvkiKAgAAEfoCAAD4yAIAANciAgAAH1YCABZtSAIAAWzUAgAD+FoCAAGyYgA==
Date:   Wed, 9 Mar 2022 19:10:35 +0000
Message-ID: <20220309191023.34fmzibc2u5tcinw@revolver>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
 <20220304184927.vkq6ewn6uqtcesma@revolver>
 <20220304190531.6giqbnnaka4xhovx@revolver>
 <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com>
 <20220305020021.qmwg5dkham4lyz6v@revolver>
 <29eac73-4f94-1688-3834-8bd6687a18@google.com>
 <20220308160552.d3dlcaclkqnlkzzj@revolver>
 <6036627b-6110-cc58-ca1-a6f736553dd@google.com>
 <105e1620-5cf2-fecd-27e7-21a6045cc3ac@suse.cz>
In-Reply-To: <105e1620-5cf2-fecd-27e7-21a6045cc3ac@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a3158a6-024b-45bb-99cd-08da02007d6e
x-ms-traffictypediagnostic: DM5PR10MB1483:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1483A9421C9BBF869D353D40FD0A9@DM5PR10MB1483.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7Thcgwblh9r99eSeT0BmOsjS1H1BLcSXDvdlQW3OvBdt5y4OqVmGuWLRdRY9TT3sEJrfCq6tweQ1/v7Rutmux04zSIWtysrjkxt7HbsLVzYwnylCzZ1mP6BObhVMgfwrFxvGXUYo37RHDJ+eNxjAsX1xpCCiiMHNvsLqykD7QapVLiGkrUYAza1xQiS2P8lGMfTxx0mouIZkZ/5IwNJM0WE9rO2gXdZ99cEe+NOUvW4yVfI4pbLOjDRigmPqyRTNgFxcvym/DN72dFv+EN4hU/AMm/4Wuqaqr+zGMn297Ua7LpRmT+J0+wMENhP1KV0bUSR/zPWyYVfACO2FIAM8trjOtcH6k9QewFUrt7jSWboGOENFNcivXT0dIav5a5nMd+CEoFbiIY01nPjLWBtAvCdUuJTa2UCI2+JJByM6ftLdv2Yg3NZgUPoZROL80pQqks5+uGx6BXOBYE2YFCC6KS3y9KtlDoYc5D8NtNAsShywEhSTkjfDyQ2Ig3VfiDackAl3E30geWLvHEZB9VD7AulvsSscmUwAIe/rPK/NGplv1DSN2hHR/xtdoG2pT//zOoMWvoX0tL7MOtiq0AZ807G0Zmj7A8su03uzywzfnTlRY1Ccpolglxvu3Ypa4QfJ/6Py683nYO3X/PHnI5JAb9mHYSFAnfAeUvEBeP89gZBAt33L3nWldaSO6Benvy6nw9WznrX43doGxITlpQHjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(122000001)(44832011)(2906002)(86362001)(186003)(26005)(1076003)(316002)(38070700005)(6916009)(83380400001)(33716001)(5660300002)(54906003)(8936002)(38100700002)(64756008)(66556008)(66476007)(66446008)(6512007)(9686003)(508600001)(91956017)(66946007)(53546011)(76116006)(6506007)(8676002)(71200400001)(4326008)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HCPqVWm0sTc++ohJBhlca1gW3sjOiuOeeNFrCjKn1gJgPqYtRI+3Pxlgyb40?=
 =?us-ascii?Q?JZ/yT8ZPX+0v3FW6XK3WN1LBl0zDLEkcv2BUeaSMOhUw2sHhk5oWfOqi8wy+?=
 =?us-ascii?Q?iTmb8RmPKfKVfsuoJ/aR8cT6YHdfPVkoUPwidsueiXwczqWjZjc4eUF5rR4B?=
 =?us-ascii?Q?YUDZo0YCrl6G7/39wXc3GW0fF5efoCjFvqeoEKGPkhnXZNJ0m3ENw9aeq21v?=
 =?us-ascii?Q?0pejLLJN/vEavvJ2FUGDfV+Z643KyuDLcq4rVwdo6TRZ+PnfSmFfgYRz4HKm?=
 =?us-ascii?Q?ThkfN9UChCFALo5oM9CryQrPYqGM2TzuGZuQ9jXXNkvoeS1YSQN8IPqNkpo/?=
 =?us-ascii?Q?QrMun7f7M3sv47TSXYHme083erwGGyohLpjrkrWSVFyXrLjMMJpwKTLVGMbP?=
 =?us-ascii?Q?kqmehGevNY4egbLjzBF7u6/dEeXRK5figBTgZRl1Tvhwvsb8FBkGdAL9FHI2?=
 =?us-ascii?Q?GK8WlJfxTBxS6f38lrWMbTXmdVGuT36jDaXgzSB49Tv9xjArzvbj+iVtMP55?=
 =?us-ascii?Q?Nvrzww3a6dIGIlaDD/JnypbGwx+BOMU5MXsJVW3JjYKLP2MEv8M0j2kwftBu?=
 =?us-ascii?Q?US5pr/Q77T29OoE79y1A7BI0qn/kftywSHsSd3m7OtOcyxX2iIDzvSuAAfIB?=
 =?us-ascii?Q?AszR4LCjH2ekmM8cDY0yo2GD0sJolrKC75J1Pir6qBYYeM9oMwrjRxVEKy1Y?=
 =?us-ascii?Q?46tchXZ3B35v5EMsPZPKrtMx9kSky5iLa8C7zeKrNMdK75Q6wlFT9ANOqgcp?=
 =?us-ascii?Q?DzxpDAPNYfZ9CAi2xwQkqbY2cjnPVaZAWlGCYLuZToDV1hA8W/cy16pLPCbp?=
 =?us-ascii?Q?1t1qj15YDDtYZaQv5r0SU8QpHxj3DL1PMSGuZmNqepR2950oEbUj92hozdkG?=
 =?us-ascii?Q?5JVNQfwgdWV/RzOoACc4Jnf9fDEquywDKnhBun+OpXNvUnCl24yN86jC1CO+?=
 =?us-ascii?Q?k8U0116lMd4ICCKXPjtyTCvLb7SbfVXqo5zOYjXMB3mcYOv1D3I3/IT2m224?=
 =?us-ascii?Q?+4B9ir94XDzRz0UqZaY5SCSQqPTYu7UyXoncVk6JEZ1qjCUQaFhp60PAEj2H?=
 =?us-ascii?Q?yxD5YqERsjsQy3+He/6sBSEGtzZ6MZUxZxqOc+olY1flmZxx5DDLvN4Q1Plr?=
 =?us-ascii?Q?lPRSgeFsmGW7o2GcYpOwWHpbGytF7oSksRg5XKk6LqhXFjFMDokadf+DiBbQ?=
 =?us-ascii?Q?L6ijWNZ46qirnugl4eoY7puE2S+QukorvM9SuUy1+yorgqnJJi+/8J+T42to?=
 =?us-ascii?Q?T+orGhOnAhS/ksSX1Nn9lf4KFPEPL2wS5BwdndNg3kh5IddWRptFrCJsbNde?=
 =?us-ascii?Q?3GxzJBEEDL/1AYV5u8LjdRpZgvET66+VsH5DtBFpMqLgo2J8LaSb9IhKugNl?=
 =?us-ascii?Q?WBXDJ+mgpiXnCHrbklIzj2g7jiXYHc2kjIQBCdaUSvRMmWp6t1/rEW/sxcrf?=
 =?us-ascii?Q?XzLex+0GWwINAx9wtK9ukoeKSozygIOOstMLrkdRwCWpG+msKC2MBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A15DAF7AC4A4B4459E329AA8AABD66D9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3158a6-024b-45bb-99cd-08da02007d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 19:10:35.2908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuprw01+nSdXuZKLx4H4YcbFK0bH9a4DvyrZKM9k9Mx00mGXBFUN1WFzrQ/TDZ/Brb5PcyUNRgOofM59WXfdJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1483
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090103
X-Proofpoint-GUID: 4DNpVlvWR-9ddGlgDG6Enm411MPlOKSV
X-Proofpoint-ORIG-GUID: 4DNpVlvWR-9ddGlgDG6Enm411MPlOKSV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220309 07:41]:
> On 3/8/22 22:32, Hugh Dickins wrote:
> > On Tue, 8 Mar 2022, Liam Howlett wrote:
> >> * Hugh Dickins <hughd@google.com> [220304 21:29]:
> >> > On Sat, 5 Mar 2022, Liam Howlett wrote:
> >> > > * Hugh Dickins <hughd@google.com> [220304 17:48]:
> >> > > > On Fri, 4 Mar 2022, Liam Howlett wrote:
> >> > > > > * Liam R. Howlett <Liam.Howlett@Oracle.com> [220304 13:49]:
> >> > > > > > * Hugh Dickins <hughd@google.com> [220303 23:36]:
> >> > > > >=20
> >> > > > > I just thought of something after my initial email
> >> > > > >=20
> >> > > > > How does the ->set_policy() requirement on tmpfs play out for =
the
> >> > > > > mpol_equal() check earlier in that for loop?
> >> > > >=20
> >> > > > It took me a while to page all this back in (and remind myself o=
f
> >> > > > what is case 8) to answer that question!
> >> > > >=20
> >> > > > The answer is that the mpol_equal() check at the top of the loop=
 is on
> >> > > > an existing, unmodified vma; so it's right to assume that any ne=
cessary
> >> > > > set_policy() has already been done.
> >> > > >=20
> >> > > > Whereas the mpol_equal() check being removed in this patch, is b=
eing
> >> > > > done on a vma which may have just been extended to cover a great=
er range:
> >> > > > so although the relevant set_policy() may have already been done=
 on a part
> >> > > > of its range, there is now another part which needs the policy a=
pplied.
> >> > >=20
> >> > > Doesn't the policy get checked during vma_merge()?  Specifically t=
he
> >> > > mpol_equal(policy, vma_policy(next)) check?
> >> >=20
> >> > Sorry, I'm reduced to the unhelpful reply of "Yes. So?"
> >> >=20
> >> > If vma_merge() finds that vma's new_pol allows it to be merged with =
prev,
> >> > that still requires mbind_range() (or its call to vma_replace_policy=
())
> >> > to set_policy() on prev (now assigned to vma), to apply that new_pol=
 to
> >> > the extension of prev - vma_merge() would have checked mpol_equal(),
> >> > but would not have done the set_policy().
> >>=20
> >> I must be missing something.  If mpol_equal() isn't sufficient to ensu=
re
> >> we don't need to set_policy(), then why are the other vma_merge() case=
s
> >> okay - such as madvise_update_vma() and mlock_fixup()?  Won't the mem
> >> policy change in the same way in these cases?
> >=20
> > mlock provides a good example to compare.
> >=20
> > Mlocking pages is the business of mlock(), and mlock_fixup() needs to
> > attend to mm->locked_vm, and calling something to mark as PageMlocked
> > those pages already in the area now covered by mlock.  But it doesn't
> > need to worry about set_policy(), that's not its business, and is
> > unaffected by mlock changes (though merging of vmas needs mpol_equal()
> > to check that policy is the same, and merging and splitting of vmas
> > need to maintain the refcount of the shared policy if any).
> >=20
> > Whereas NUMA mempolicy is the business of mbind(), and mbind_range()
> > needs to attend to vma->vm_policy, and if it's a mapping of something
> > supporting a shared set_policy(), call that to establish the new range
> > on the object mapped.  But it doesn't need to worry about mm->locked_vm
> > or whether pages are Mlocked, that's not its business, and is unaffecte=
d
> > by mbind changes (though merging of vmas needs to check VM_LOCKED among
> > other flags to check that they are the same before it can merge).
>=20
> So if I understand correctly, we have case 8 of vma_merge():
>=20
>     AAAA
> PPPPNNNNXXXX
> becomes
> PPPPXXXXXXXX 8
>=20
> N is vma with some old policy different from new_pol
> A is the range where we change to new policy new_pol, which happens to be
> the same as existing policy of X
> Thus vma_merge() extends vma X to include range A - the vma N
> vma_merge() succeeds because it's passed new_pol to do the compatibility
> checks (although N still has the previous policy)
>=20
> Before Hugh's patch we would then realize "oh X already has new_pol, noth=
ing
> to do". Note that this AFAICS doesn't affect actual pages migration betwe=
en
> nodes, because that happens outside of mbind_range(). But it causes us to
> skip vma_replace_policy(), which causes us to skip vm_ops->set_policy, wh=
ere
> tmpfs does something important (we could maybe argue that Hugh didn't
> specify the user visible effects of this exactly enough :) what is "leavi=
ng
> the new mbind unenforced" - are pages not migrated in this case?).
>=20
> HTH (if I'm right),
> Vlastimil
>=20
> > Does that help?
> >=20

I think so.  You want to set the mpol the same across the vma because we
are specifically calling mbind, but it isn't necessary because the mpol
is equivalent but not the same mpol?  I guess I have the same question
as Vlastimil brought up - why does tmpfs need this?


Thanks,
Liam

