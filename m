Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F54DD676
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiCRIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiCRIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:51:16 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00089FDE33
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1647593396;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=y3TVysCnTsChceQa/duCopfCWNMfkj8gGZm1vdYlZRM=;
  b=ILoHzGR2yScqS3TKJDm8JeLuK7aJSupVmOOyCoo2nvK0zKNbfHN1EF8f
   eEaSIWzdHhEFmupPCid23TLrUkGOfcBm6YH+9o5CXn6AERJJGdO/8rt2O
   pj4wKdX//5+0eq66kZItopS2C2Cyib3Xp2ysZsZjHYmNZ4ZPp9t/M4XpI
   E=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 66983729
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:QMVsQqp3zLvo9N+eZsVRmCq0ZzleBmLeZRIvgKrLsJaIsI4StFCzt
 garIBmGOPqJY2qnf9t2PI22px4Pv5SEz94wSgFvqC9mFS0Wp5uZCYyVIHmrMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 IOq+qUzBXf+s9JKGjNMg068gEsHUMTa4Fv0aXRnOJinFHeH/5UkJMp3yZOZdhMUcaENdgKOf
 M7RzanRw4/s10xF5uVJMFrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKv+Zvrgc91Zk
 b1wWZKMpQgBHvyPx8Q8Xz9hMCw5G6Jf/aTfEGGzrpnGp6HGWyOEL/RGCUg3OcsT+/ptAHEI/
 vsdQNwPRknd3aTsmuv9E7QywJR4RCXoFNp3VnVI1zbWAOxgWZnea67L+cVZzHE7gcUm8fP2O
 ZRIOWEwNkWojxtnZ2Y8MM0Mp9WToHzUeSVx9nuX+ZEQ2j2GpOB2+Oe0a4eEEjCQfu1Fk0Ddq
 m/Y8mDRBhABKMfZ2TeD6mirhOLEgWX8Qo16PLm58ON6xV6e3GoeDDUIWlah5/q0kEizX5RYM
 UN80i8uoLk0+WSiS9DvWBv+rHPslgUec9ldCes37EeK0KW8ywSWHG8fVRZadccr8sQxQFQXO
 kShxo2zQ2Y16fvMFCzbpuz8QS6O1TY9DT5BOg8lQS08wNSkho4qiwnXf89vD/vg5jHqIg3Yz
 zePpSk4orwci88Xyqm2lWz6byKQSovhFVBsuFiONo6xxkYgPdP+OdT0gbTOxawYRLt1WGVtq
 5TtdyK2yOkVRa+AmyWWKAnmNOH4vq3VWNEwbLMGInXAy9hP0yP7FWyzyGsnTKuMDiriUWWxC
 KM0kVkNjKK/xFPwMcdKj3uZUqzGN5TIG9X/TezzZdFTeJV3fwLv1HgwORHNgTm0yxBxyfhX1
 XKnnSCEVypy5UNPlmfeegvg+eVzmnBWKZ37GPgXMChLIZLBPSXIGN/pwXOFb/wj7bPsnekm2
 403Cid+8D0GCLeWSnCOqeY7dAlWRVBmVcGeg5EGLYarf1s5cFzN/teMmNvNjaQ+xP8L/goJl
 1ngMnJlJK3X3iSWd1/VNig9NNsCn/9X9BoGAMDlBn7xs1ALaoez9qYPMZwxeLgs7ut4yvBoC
 fICfq297j5nGlwrJxx1gUHBkbFf
IronPort-HdrOrdr: A9a23:Gmu2Oavjxxgkli607VT3NdNM7skCkoMji2hC6mlwRA09TyXGra
 6TdaUguiMc1gx8ZJhBo7C90KnpewK7yXdQ2/htAV7EZnibhILIFvAZ0WKG+Vzd8kLFh4tgPM
 tbAsxD4ZjLfCdHZKXBkXmF+rQbsaG6GcmT7I+0pRodLnAJV0gj1XYDNu/yKDwGeOAsP+tBKH
 Pz3Lshm9L2Ek5nEPhTS0N1FNTrlpnurtbLcBQGDxko5E2nii6p0qfzF1y90g0FWz1C7L8++S
 yd+jaJq5mLgrWe8FvxxmXT55NZlJ/IzcZCPtWFjowwJi/3ggilSYx9U/mpvSwzosuo9FE2+e
 O86SsIDoBW0Tf8b2u1qRzi103J1ysv0WbrzRuijX7qsaXCNUQHIvsEobgcXgrS6kImst05+r
 lMxXilu51eCg6FtDjh5vDTPisa2HackD4Hq6o+nnZfWYwRZPt6tooE5n5YF58GAWbT9J0nKu
 9zF8vRjcwmPm9yV0qp/lWH/ebcHUjaRny9Mwo/U42uonRrdUlCvgolLJd1pAZEyHo/I6M0kN
 gsfJ4Y0I2mdfVmH56VNN1xMvdfNVa9NC4kEFjiaGgPR5t3c04klfbMkcEIDaeRCds18Kc=
X-IronPort-AV: E=Sophos;i="5.90,191,1643691600"; 
   d="scan'208";a="66983729"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VveOmO/KJE/L3E3Vj+qrzBpv2ZA31dxoMmJZDsTNF5ggYa8J/+mNAm8A5a/icLFhVDNA1RadPwr6dMFuh9YruiqQmQKXtQvgQD7FGuFXKkXvMu8P0loDRSKc20gHFCDA/FhxzvRibjk3C2TT9y3IdZv++fpUViHc+TlRz/w2+W4R43PDW7ELtZalcRH5UrYqvv8ofO/aOTR1lpDiJkCe10IwZqGipv99fHHSNuPiTg9qUhfGOyDweX1U/ufpk2Eh+bRQnQplGu6BjElXN6FGV4bopRYnfoJFz7K6AzFKEa6OzQeh7Qz6WsXzA8WPaOdu0vmvqmPyir0nAAfFakljEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbxjN91XX0D2KTVVL4qj+OaDO2AHs/sSAc4R1mDZ4AA=;
 b=PYFP6gO26afJwLAmsNtz5gV68V3nOa0n6e1m0ZJGF3YMyYUMU+VCUsmYe79zrtFuFNQiAwednNu1YnJLG1JI1EUvbxQ0XqA7DC6Gp1Frmqo+Y/yxJ31i/gxTmTV958c3wZ/N0iraJR2Kp1CgILPMu8ztihgx+LvhResBNUktZzUp/9F7XYSVDO6S2D4sMK3fMBY+1onbbMMiHoTRNkZHzvEjRF6uKwAXQzQ5s36cd9EXgtoJtZyIcI0nPkZMeKSGS/PUc1Pb5Tn742ljTNWlydP3z8O8oeUJBn5E6XHdPxkYQPjCNnMiu39ZYMrWkCWZaQym0znohVpdDPZRjCajew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbxjN91XX0D2KTVVL4qj+OaDO2AHs/sSAc4R1mDZ4AA=;
 b=ejDem0m6v6eOeSarFBuOGfyvLOJ1yMnw7M587HbR0eayUyZo3mpMeZCzbPL6tuTVmzXT1CAcuw/upH+mlV3LDTAJ2u5s9KjNbaiBCuSMyjVLhQxyd3zXGW/Mu1Y/tSUKwWhfSRNFQb9z46rQOrhjR71anicbY3bfgArT77LBB3U=
Date:   Fri, 18 Mar 2022 09:49:43 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     <sj@kernel.org>
CC:     <jgross@suse.com>, <mheyne@amazon.de>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blk{back,front}: Update contact points for
 buffer_squeeze_duration_ms and feature_persistent
Message-ID: <YjRHp8E6Ehm24QgC@Air-de-Roger>
References: <20220301144628.2858-1-sj@kernel.org>
 <20220318084600.26243-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318084600.26243-1-sj@kernel.org>
X-ClientProxiedBy: LO4P123CA0129.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::8) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9649d89c-4118-49a6-896a-08da08bc4297
X-MS-TrafficTypeDiagnostic: DM6PR03MB3593:EE_
X-Microsoft-Antispam-PRVS: <DM6PR03MB35935EB16FA54B8FED5756908F139@DM6PR03MB3593.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btz2+wBI/fFOlUiKIkmBfJ8KmlhTlUUVufWDRdmSiidmlm+SBopUvYjy2TmuEEpjjyIS+cinGOCior5LdWVpEsEPYmZ7idYf1HOqlLqrD4TCYrbrqdnFNndiJeq+TEfAEX+4i+ob64/qKYawmJHOaGU4CPQccMB0tfUOcv2Rvo/UWTCM/3PAtsxOc+sCzDFBzYwRpb5kIn1qFg+uL+oSQtqTocgpybUhSUXKBbezCiiRLqEv8GCeJngQnQpa7tm9vgGd3/eJrwHvMwMtJ2UwYJvHLpRCZ7zhW0Y3Y3zVPjQ7i0BfYVb39XJl+RMxfwtOEAOg33JQdw6vkQX2eureCC+irGOGjieTQOKEbZWiiyixE1/pWyD6t7xUj6TrnJVh2DbRhsoTHjy077QwkVR3g+WSFtDUdU8fj7q3UMK4JaWkOnr3S8JUkCMsGfBHge5wYvcnkS5kDCdoNXXHBS3x8OMdeACE+qfP/xeLO3zfdGCIUB3//+j0927WC4xB5bOJ6or1P6uqNA6e97+/rTV+ye9F/8Rm6+dwsiLK8Sn4vhSvYdDXLsQeDT7QkNQBKkZ0jmk74R8+K4ePd4pd/hr3rmAOWaBoPkjIMQGIFfZZuFT4RyPtI5dFVVGHGahUKxlTqA/Le4hgTeSJr3SaREmdyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(38100700002)(86362001)(8676002)(85182001)(15650500001)(4326008)(66556008)(9686003)(6512007)(6916009)(66946007)(316002)(2906002)(83380400001)(6666004)(508600001)(6506007)(8936002)(66476007)(33716001)(26005)(186003)(82960400001)(6486002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU4zZjZHazhwRUowR1dBcFFVS1YzUGNncU9TcGVGaXJYWlRxUlJKTVRsNzdr?=
 =?utf-8?B?cmFoeTk5V2NpeFNSUVJDY2lMOGFJd0czb1o4dzZRd2E0bndIZVdrUGEwQU9W?=
 =?utf-8?B?eWxkY3ZlNTNDSWtqVTIzRlpaYXlzcThkSW9jZCtxMXZKaHVGeDhDdzhPQm1P?=
 =?utf-8?B?ZFVJbWtqYjJmdFluc0Q4elFMWlJ2Ukp3c01WcCtrbGh2QXF3SE8wL3o4cFdF?=
 =?utf-8?B?ZExKaGJyWXROOVdkeE54QzZSOW9PMzVxNU11azhTRm05Z3pmUWpkdGFDZXpR?=
 =?utf-8?B?WC9ITFBMa0g0YllxNk91bG9MZkZqVzY1MFZ1ZVFhUWlsSVNkWDJPdkI2blgz?=
 =?utf-8?B?NHMrTW5zMDd1N3dkQTBzakFpaXhIUW1SOGZFM3lMRk1MY0RPQ3RLNEMvdmlx?=
 =?utf-8?B?VERWekpMQUxBZjMwcUY0NzFxWmJKc0tuSmYwd2pMM0V1S1FIY1NwUVBLR2Y5?=
 =?utf-8?B?eVpUdVB0a1ZsUHhqU0JBUGJwYUR6ZlZCU1p3aklkT2VBd05EVWI3cndEck5M?=
 =?utf-8?B?MHpKOU5WaUJXLytQMVIyUlhZV1dqL3FadW1oZ0JKUGZXaUs4eXZPdnFoTThz?=
 =?utf-8?B?Sm1qbi9vQlJzUjdBUk5tZjEvNTJQb3JLWm1QMWtHK2NSYis3OHZadW56UFla?=
 =?utf-8?B?ajdXWVZ6QktzdEtoY2FWUy80YUlVdVh1bHZ1RlhlSC9aY3k4Nk5zK0x5VXgw?=
 =?utf-8?B?YXdiNm9nOWQxWlpPOElpcGxiVHNoYnQxRHE5QWhTWHN2c3k4dXltNWVtdkhl?=
 =?utf-8?B?bGNnaXFpbHJvMkN0M1JjYUd6M1lnRjZlc3BERjJrQmZldTZ4bmdrSXBURUF0?=
 =?utf-8?B?VGxyQVR2YUcwUkkxeEl2cVVNMmVYQjFDSzhVUURjVGl5ZDJYQlNtNWNmWGlR?=
 =?utf-8?B?WWlRVjNOYXNzaWpSRGFYQmY4ZmFhQkxIVG9FaTJxK2hIT0V2eFlyQmpwck9w?=
 =?utf-8?B?OUpNUWpCakE4bDhqcDlaTG5KSCs2dTFCeURmQzMrWVpzWEtDb1hpQng3dXJG?=
 =?utf-8?B?SmRNL1VpK3lRaUh4OWlyODVZS2VxOXc5Z0twNmJrYmo1N2doWEtQcWFFTjJv?=
 =?utf-8?B?cS9FWVhmKzYyNDM4QXdHcWN1OXRrb1R6eXdidkRNb1FEWTM2SnY2c2Jmakgy?=
 =?utf-8?B?TEd2cWIyTXlnaUxPYXFxWUJ5dFVNRUEwcHU4cytnWjZjMElpRlpjaklYSjdH?=
 =?utf-8?B?UzFRR1JTK3FsNHB0RVFteldQZFhQczdtUzNHR3J6TVNCeFMzUW52LzZMbG15?=
 =?utf-8?B?Y0tuQ0M0Y0JFT29BcEVzc3VTazcvOERCaiswLzc4dUIzamlkRXNNd3RGTzg2?=
 =?utf-8?B?cTB3a3pRN25rYnhIeW1iVEdLVFRYVGdCQ0UwbUtvUnpsWnM2dVNRUUNMRzAw?=
 =?utf-8?B?SzdSVVZBZXY0VjZRTjVRTDF4TlJaYVV3M20yb1gyWlVvMTlaVXc5RGt2c0tn?=
 =?utf-8?B?TVNFZ3VERGpSem9CKzB5eURQNUI5SW9hdnhMY1RXUjM3REREbGtKNS9ZR0Jv?=
 =?utf-8?B?d3l4RzRMQll2ZE9mNmFKNTVVQzJHWDB4aDRkalR6QWFraFFBSEZLN1ErcVJI?=
 =?utf-8?B?V1NsbW40NWxSRy9COEw0RnZ2bXA0N0lTc3VXN2FQZFF6WUVzSHByUE9kWUpS?=
 =?utf-8?B?ME9TNnNCbThKZ0dIakxaa0VIWVJQT2d5OWcrSC9NenplN0ROS3p3aFRYOTFp?=
 =?utf-8?B?ZFVaMmRuZ2d0cnFIZ3RGd2xmZkY5elFZdWRTRVRFbHBOaVZxQi9EenQ0akps?=
 =?utf-8?B?SlNXYzZLV1kvczZQY0ZZZ3hobkphMVN4LzJYaitwSmxpMTdPR3FMSlVyK0pC?=
 =?utf-8?B?ekNMdklENFdQWXBzcEVENzFwL050Mno3WEZSZzJPNTlqK0xVcmRYUy9uSEtx?=
 =?utf-8?B?Tk9IelZGNGFWVUQrWVIxUnEvTmkwRjBORUtOMGNaTkhKUGE2RzlIRjVXblJm?=
 =?utf-8?Q?uUvlhXewm9sUF0S+MWBhriyNldYL6lyy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9649d89c-4118-49a6-896a-08da08bc4297
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:49:49.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwO6da152Wq23fNy/wgmA+DAyBUf35et8ZvQimbHmtf1JKfc6DH74B6C6xlT9FxacKQNzZna1Ku8a1JS7PupFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3593
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 08:46:00AM +0000, sj@kernel.org wrote:
> Hi Roger and Juergen,
> 
> 
> May I ask your opinions to this patch, please?

Sorry, I was expecting Maximilian to Ack it, but I see he is added as
SoB.

> 
> 
> Thanks,
> SJ
> 
> On Tue, 1 Mar 2022 14:46:28 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > SeongJae is currently listed as a contact point for some blk{back,front}
> > features, but he will not work for XEN for a while.  This commit
> > therefore updates the contact point to his colleague, Maximilian, who is
> > understanding the context and actively working with the features now.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
