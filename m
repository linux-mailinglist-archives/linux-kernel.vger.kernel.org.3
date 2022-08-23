Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D42D59D7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 12:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242408AbiHWJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbiHWJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:42:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF119A96F;
        Tue, 23 Aug 2022 01:42:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N7dcUe007547;
        Tue, 23 Aug 2022 08:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XsCoR8O0AFECgh3ZUCbvSZDhDLpcJKs9cprUTkdfEYY=;
 b=wirF3m7FqAkLFvVQLAV4anAvZXpWV0HJyKGkffj0a/sJbXXE2VFNNR3xOTBDzsMmMWWC
 utUQiJWcu+txSAgVEKKUzLe5+XpgNbwLf3d+yH8LEMr5pFvMKB8olBAiHxbSJ/SMMAi/
 K6FX3pQX7aiFDQFCtDR1iRaB3u5CqEiYLxbNtdVST4AshWSSPcbzyCaPAHTgXMkdB6ud
 OhfbhNv6GryYW17+zU8FU+fyTF8LdTOvjOL310Z5D6CSg+wJUv2iijD+jdbOSdVgL5yV
 faBfg1gZxwdmDSJdyJm5iUSKsq6wkUH/Cpar6O2s7c/I5p8krHFUu5tKuw7jPrZd0ooC dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4eu69eh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 08:42:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27N8H5kR028280;
        Tue, 23 Aug 2022 08:42:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn4mxsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 08:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxz0wm0FjHPXGtVQ0M2658sWmWlCYzo4Sz18l5P+m3m84XYY4DccZ+H0zj565Vq7q7QY/+RLZUjQqxj/2LuqiFs/0JIli9m4nPsZcN5NvgynDRfqTKm1s9027xkJkD59wrOz/WTn8zXJwXnQn6K0GAty0bQImqkYuB5BPas0CyBiUDnUQShhbB9fVw/leAW4f17WmfUkcVjmaBeWwUUxbC0x9ptsWOh69RdxfzKbReZgQRZY83zqwDy0YbxfMTIOdXIG8hKX1vYXv5TwEr5uzu+zjCHvn9AZafiLyBWA48xBl+/lZpL4+bFw+lbdFytkNpQ/USmVE3xAfHoTZ/a4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsCoR8O0AFECgh3ZUCbvSZDhDLpcJKs9cprUTkdfEYY=;
 b=Sz7xRj4cVi9JVDUwhzf8rqQyQaZhR9nSeOrX2fN9bnMday2E+ypOPJy4pbvaGmH+zH9xZiZdP17k6a8Ysqk9rw4P0Q9p5Jwcb5xC3fRgxtqyQIIzx+bVWUkmnaNvpT/KZgOaeN46dI2x+lsaSGi4lxY0/n3w8VKLwEMiyUAcR1ISd1wWkzdNspAXI6SUTJz9Q5QIXph2UI3p2HsdjrE5SwQPoGHjy/B/t4QGLrAIUim8lerlt+4+vQ5KNd54VNQy0yKdSw9XLz6QzSaX6LhGQ2533okXWXcHFXmpexpZk3sct9H6+cIbHchEByc0deaUobHD86hvP4eKviCmJVxUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsCoR8O0AFECgh3ZUCbvSZDhDLpcJKs9cprUTkdfEYY=;
 b=K+kuRfepOpIfFpxIdd8ZXx3PieIm4iabeYyRmr1P1SoTdREvkMR7vnwjVctIlkT6asGgbLos7VraYZacOgr3L40XXfeNRNMxHpyqlFF+D5Val8dlkRDx6ztyLtz3WPdExBpZp9TWUMylJ4WGJi+KpN6PdsXs2vD/ll1EwuCkqA0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB2027.namprd10.prod.outlook.com
 (2603:10b6:3:108::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 08:41:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 08:41:58 +0000
Date:   Tue, 23 Aug 2022 11:41:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Christopher Carbone <chris.m.carbone@gmail.com>,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split multiple assignments to individual lines.
Message-ID: <20220823084133.GG2695@kadam>
References: <YwOjt+ZrQkKFGRH9@valhalla>
 <434d644b-2688-c3e8-814e-b9b2f2b86f85@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434d644b-2688-c3e8-814e-b9b2f2b86f85@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cb51a69-9c4d-4793-1e80-08da84e35710
X-MS-TrafficTypeDiagnostic: DM5PR10MB2027:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+1ELC7yRrzoH/jjF8fATaa4sR/Sp7cD+6ihzK+XEQUaht7MTMu40c/ke+Yx7kMi3ro9FDQS9869mBpd0/HnAMB0+fYN6/FMG2Jeh9gNzzC8Wgn35jtihwWK1/5YhxTFGq8uTkNATTOUKr3guQMN79aU+MCV3ss9635PsYWcrrk/GNiFtS/pspEuHooBlM/L5R8abYX+RCDnSXXhV8ScnLFdBZcBswfczwSXKCA3Je3dHwZgbgqpn1GXk7msNxesogu68WTnd8jIY8/+UlTnlxck2r6br00kHcT8EoKNxJKVBjfJ7lYKLsKjaIb1K8zmMXe33rIIWoHEngzd87fzThRNWKF6isrsuSdesSr/MtpWMeRbXOV64SQnIc5+MSymwlB/xGnMhsAbua1kbLeinnysErS5eAkuJVX6h+/1P+5U01SitGE8iYUuxH5a3rvpRY2nyCAIdBCYHWpj6eP2Uo/JwZ11EEY0m6iDSB7Ym+z0U3SMPko9eWUzB6v645W0jisBQWJU3S6wzspOBO5biM1AnsY1aeoZB3Ypp+kOuvBADSKvMx4ZU7vTJ6YHYSOACUPxfB6shSkXKcXlKM/36FXEcxEZ7PhoRuf/pGEcnCKkigG0DJE3gNWvl4NclRi0ZZ04eU8XkWNQ8PbK9GIJlA/hBz37U+BJ7rmKsnOay0XKEECdvxY4Q9q0h4jajKs+kzJVjefEvEM8WX5G1+JiwQbkjx2cSI/dRItwqhj0PNsiry5YCY7+L6/sNTuq3T8The1HGqYbKUSdnrSyPn4ULA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(376002)(346002)(39860400002)(366004)(396003)(6666004)(478600001)(6486002)(1076003)(9686003)(6506007)(186003)(6512007)(26005)(52116002)(5660300002)(8936002)(316002)(2906002)(4744005)(33716001)(41300700001)(6916009)(8676002)(66946007)(4326008)(66556008)(66476007)(86362001)(38350700002)(38100700002)(44832011)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXJ8pQ9yHvi+y8MnZduTUEWJflGubqKEZJpA2SIwiXD1pyjJLJGnJxrZpOnd?=
 =?us-ascii?Q?rqB8rANToi7WTlonVTxU451oPDBUZ7HHxUbAnIYBkYp0Se4ICbGesyT7J8g2?=
 =?us-ascii?Q?TJ0acsXPFy33Gy2noa9D9n/mtGjPEJxokwK/ys9WzmzzdqP5Nmscg9oVfGeE?=
 =?us-ascii?Q?ZoiRJzF4xIdoRNHVewkLBk8sziKugo/QscSvnzUZfweGa/4UaSVW/9EWNIt/?=
 =?us-ascii?Q?HPAXUe2N2k4I3HqFarIkwmRXIUKmJ2JZMx34jAdPt7U6POOUxyIyfkw0HOeH?=
 =?us-ascii?Q?FaY1MKw19dpL0ImWHBJ4zsjDMdVgZzFXGggEIq2svtloIxNyiwH1nGtx9MiM?=
 =?us-ascii?Q?wgUwPz/d7ZqLvDZt+FQ1Om1xWpYKJUqZ02jKI+oKEtPjkR6PBggLbmvdGWSD?=
 =?us-ascii?Q?hOqaVcdpogqE0n9bS2UxTZaUI42Y4J+DcrOaTBPBak89OEMR8Md2mr2biLG5?=
 =?us-ascii?Q?wZpzXSQ8dK5fQpGIcBcI6nLDVxb8QnSh831yZRHGguqJXcQL8rwO7yUZUkUK?=
 =?us-ascii?Q?AOGfM1K9GW4gss1qWw6sQeyh8u3PVrE5u7g73vxmgvTS28WI8nPeby6qQeat?=
 =?us-ascii?Q?eLrolVKpDqt0EIw+HcyRmVTYa4zFlVZDN4lKwcwKvfb1XjTmd0NUa/WREIWr?=
 =?us-ascii?Q?ZtlnNIF8DQxOclSEnK3wHPKLRfKI54QN+ejt3GvWiWR7p19XDCtXFWIXqRxO?=
 =?us-ascii?Q?lwkbNi3is90gwz5kObLZEfwqhFBz78jAH1WKDTh6xV3Jwo1h5MKgP1xq3fl5?=
 =?us-ascii?Q?t1RZY2AyzV1LwH7OaX0oVJM5K1Qc/Ks6O/7nH6HX/BG1saPezOjUtc90tP/0?=
 =?us-ascii?Q?nLqAVMipv9IfcmEiiR3EUZw/OHMphNm6KhTgZu151izkt31k6cKK1VrJzvZn?=
 =?us-ascii?Q?ugiYi8HjNYU2zMJvJfSTxUpOykqdN+cxPCOP+bLTLRlPu+TPODtJ7CLM7fI+?=
 =?us-ascii?Q?eEFD38l8aQ41AGeh9g8AgL/YTiMe/PjG15UPeONiktK+oK3HXE7O/c95JRG5?=
 =?us-ascii?Q?A4+JWIBvLXhjM2ElQSJmPujerxk0oHqc4g9POvdqw8dW4/VC1j1Ytx+/UnnY?=
 =?us-ascii?Q?ysnJmxKyjv1ZK0IBxxQrGnjlBF/ibolwOp/kovMmU+79IGL6y4C4cLQpmfEd?=
 =?us-ascii?Q?ciMFKg7Jo0nCpCcriTk/q3xOOF040N9NYxsJzLDIag89hH9SgGh7FARAjZ4B?=
 =?us-ascii?Q?T8JTe4cNPu5frzYmKkatYFHj5u8UXcvywoHeBPl+EQ3UiJLGQKM4Wcp0gCsY?=
 =?us-ascii?Q?wbI1276O20YJtKAq+qUeNGYWwtH5iRnwj/ftVtPPj4qIajz1qjkGmiL5HBZm?=
 =?us-ascii?Q?VhKrR18nR80kY7L/6oSmsqYLZhueu9R75SYe7pI4/KVO3oe4BcP4/WbNcuaI?=
 =?us-ascii?Q?GtoX0vBgPHW2FcChyAJvL8HQJIMX30UVwKrHiB5elSz9zg/aX+y87mgpVlEd?=
 =?us-ascii?Q?E56iutlL0RTblUi6y0JEXc19i9UUXuu1O7yXXaJ9AgbJ3w6Tnxk44vMJDdA4?=
 =?us-ascii?Q?nZAAe3VGHg8vp6Ykn0pV+1eOhiPj+mFJrBh7stRuuvbV5uzFXjFCGq1P4qdc?=
 =?us-ascii?Q?sG/k8G+6DW5GSPRlXxcrvqbKq8+o0N5C3pYinkBPvrofFBPYAYqQgTGWthAm?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb51a69-9c4d-4793-1e80-08da84e35710
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 08:41:58.1494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed9fJcYX9Ee/vj6dFl99E79jnKDHg2mOYW6IExvYLPosXOWRMm2zwd6BDp+w0d8d0XjQ64XxLvKnQVNiFWFzl6FZv9z5QjXqXX1g4aufsQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=872
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230033
X-Proofpoint-GUID: EdfHFwYMn4tIxHAgHZI7nSC6TCvg72y2
X-Proofpoint-ORIG-GUID: EdfHFwYMn4tIxHAgHZI7nSC6TCvg72y2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 08:05:57PM +0200, Philipp Hortmann wrote:
> I personally prefer more this:
> 
> > +	sm750_dev->fbinfo[1] = NULL;
> > +	sm750_dev->fbinfo[0] = NULL;
> 
> That gives a better overview.
> 

Same for everywhere.  Literals are clear than variables.

 Bad:	foo = bar;
Good:	foo = -1;

Avoid pointless indirection.

regards,
dan carpenter

