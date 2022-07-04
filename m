Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3A564CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiGDEx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDExX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:53:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2023C56;
        Sun,  3 Jul 2022 21:53:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2643x1vn023139;
        Mon, 4 Jul 2022 04:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=uXkBllE3kZLcpHEjYoJCuit4HijNmmrx/Je5YaU0NuI=;
 b=LP8Wva8gZsUNkFX/alyJr02UnDVX5tVru+6XOn+6UI9kxUX6VsvsAehVTLpl6INvcPuE
 FEIfWsSzbF3qVJ0bENKZKjwGglj5JDpECOhPQM67kvdKwXygKAsh/UlmXjDafZED00Vw
 Ei/tVMxnCr9SM7sqoCtcXMITiygY8NwXJ2VMKJlG5TYeRP52tgYH/Mpz07UwNNHWLVXd
 FwJDbSCO9xIBzhcWfNwP/AXzlh1zwrtMVl09nAdzX4y87ex0AVlNjLCxpK/Rx9/KJLGY
 fH6dA2roVP2CP/Bw6GJpANdU8ZeyfyoMDKyjEpG+VxvjxEzJsbWSdajB4HRjrfXr43yS QQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2eju2a6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 04:52:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2644pKNm014076;
        Mon, 4 Jul 2022 04:52:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7e9d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 04:52:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/+nXjUzTFXArPFL9hj18HYtMQLecCuL7E8w9T0BuYHP3PpGYgtoaElYFtcytD1b1+kbjeHiwEUUr2tABWEQIMqMKn9ApqR9y97qtZMWDN8aTImcWAb5cwLbw75AHMp1OHiarKcCX7Yk5z474edYH+MupFjtCbA0I8vD0BSnsr+K9mzaUmIxgynW7Zp+0DlXlw3+xKDXaOHrS1fPs5tNjV7XlFN1ripzI4aseFIgE6lC5hsvc9pnxSyMrJAh7g1gdx8U0b+OCYMf/ojad0SNBMbav1OlBUbTiIL/h0y1mY2IcjPpQXW7NWS1RcFC8D1bIxDXLMh6Q8Yot/c/bRk3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXkBllE3kZLcpHEjYoJCuit4HijNmmrx/Je5YaU0NuI=;
 b=Vmjm0pEUeRBqrPoR95p93adXLs4gJv7Q4l5VTvURyMuSqt5fJkhI0m6bSqivTbJT3i4E8AiLUq3OInjom0Frpa9g+QTtL8ZckGkitLTrtQa+d89XqKbwyNn3OO9vbkw2IR74C5cunbwKm0T89d73rc5HojU8wg6dvbeh8C5aPGb/eGjyhnuLPY1RHBdtd7wEdzW6KR6+X0eM0Qq7vzPyWg2RSwET1zLFSl6VymMmYAHGbynPCdxzJt0LqhdbdF290jCLmpt9sy8ggGwczQtw4q79lM+RCPyl/5dCC6Vii1WyszWJZCc8WVd91Y8Y9F4zf6By19ARDjYh3A+Ubfb/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXkBllE3kZLcpHEjYoJCuit4HijNmmrx/Je5YaU0NuI=;
 b=rnm27UcLjNdafvEtOGuadwUepknORXjIUveeVcfQYIROEVEw9kfZK4zcB8YIsZY28gnb1ZBMhLaFgXa0vzA+rtUwShMZ4FUjXelWzuCqu64Sp7oF/4X+B7QHK3GjDz62b6SmtPVnGNb+4BYYh/GQdT0yGHnoZE3AnEgk5VuAHUA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1889.namprd10.prod.outlook.com
 (2603:10b6:404:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Mon, 4 Jul
 2022 04:52:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.018; Mon, 4 Jul 2022
 04:52:49 +0000
Date:   Mon, 4 Jul 2022 07:52:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <20220704045229.GT11460@kadam>
References: <20220704003219.208409-1-ang.iglesiasg@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704003219.208409-1-ang.iglesiasg@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d5f0e5-12ee-4fd1-fe93-08da5d790b90
X-MS-TrafficTypeDiagnostic: BN6PR10MB1889:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJB7NnN3FePGQ48r/Q6+Yc8p0xavjdv+aVITvsTTnpTHdGi56zoPFByD7ihSAigQK8ijO2V0lQPm1LmeDWLD/iVPAq+ODWtLMgYbFZMTgIYyqIMOP9LE43Cpt3Uaw7V6mi9AdelpSp39iIXRgi4JLMyPJL+ySKzTLHRnEZSXPk/GXbHdc/xBAhGxhNMvJpKuSUF/UAl0Ha3Cvx0QwO6ix1esfKwjXZ5XsFUmZxxGFX4xOY95bbbfaYXKlIlrdszhOsyEnRVwVwZJbrFys3Ftb32RfRi4HgngX1/4hxUe0iweqAcPPBu9pZH/aODfAamLeTLb7AvBxdcm+n8uUQe3VorhXPB7Riddabz21YdSiVVgGYzDaIV89YiRn4Q2pQLntmbJ90+pAnhZRglJCY3b3xKQsntVZUhr24GdbzW8B/hnV6WOorsj7+Xlb7C2NzfsHHZke2uUPf4mdXUjpq8jSu4K/3VzxzV2YPMjGY6P/J65ItJn/jml44zHkRUuVpiUdpYWCsQE63bhVXGWVWBa9Z+xlxPGsVsRCywd7GDZFJsdz/Vsm73mhJiaI3o+rWSvvtNIP5bjUiA8vvv8DlsEwYM0SYte/4jjOYCIkLMeRkNryD5VvfRA0b8BgLT9Ke/mmVXgUVfx3T3WuNrdFieIwTyvr9/+jpuTuuIMZvqYf/7oGjO1cLWlUfpzWYnHfPx0XES0S9mpBJtiksTDXU1caSaFxhzf9xP0BxJTfTKGISwvxDA6GS7U2OUiLMhgnmXkeAHnnGphQzKpSY37xolat14UXW+EG+3Y3x3XV4fSs4JdzTZTNvHCiaQv7nHBagxA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(346002)(136003)(39860400002)(186003)(1076003)(38350700002)(38100700002)(54906003)(8676002)(6916009)(66476007)(66556008)(66946007)(4326008)(316002)(52116002)(9686003)(44832011)(6506007)(5660300002)(33656002)(8936002)(6512007)(86362001)(478600001)(6486002)(33716001)(26005)(41300700001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WoMeG/QII8gzkMa1W2AszjCmxR0Y9dF3v+w2hLqDJw2YK5IVQiPOanENEALZ?=
 =?us-ascii?Q?7DDgyfP+y+xeBz41gj124NHUMv9zvwHHXjikSmtWKnb+J8IHE4FZjSWmvpiC?=
 =?us-ascii?Q?35X56bQDYAQdhFNpWgxg4uD51RWe0kQY8zibmE6+QaCgmKhaa5wKI0NaeG3b?=
 =?us-ascii?Q?xFYQNS8WNjh36BjrBy1IvYhvUR35ujWB/LddQDM1dUJJtSRy03G9o881L4hw?=
 =?us-ascii?Q?S2N68UKIR5aaZ7yJBtsmG5E3RhA53rOBJeZfRlMEwaK1XV5XPZwTpSqYY31l?=
 =?us-ascii?Q?5nPIFz8HvJy8Q6nVlCVy13zW7zXNQoMiPcmx1u+HiPOLtptcev0ou0sK0396?=
 =?us-ascii?Q?V/IGjRxSY4wEecCqmyt1oK1JfHIDPsdiFeaijpwrx4T8/F6WRda50v6Y8jY8?=
 =?us-ascii?Q?XeE7nFKubHAmhfWjCBoEGA0KFJolQWELf28l1mGYNcspJDom0PsqRUu3wd98?=
 =?us-ascii?Q?W9n9eZncKThowz36ZXl67TusPmto82qqcCrM91tbTpEfn7woI+LPinn4d7g1?=
 =?us-ascii?Q?x1+/I3TlfXi3KibAaYzhl74rYsYdBI77fth9J3/HU51bvR0jPvPpUqO8I+v7?=
 =?us-ascii?Q?MyROXjGeL+jK+9ljTmSwf74dWlVQmenP3KKeDgY8ABL7abAyC0qyk+ct7NGh?=
 =?us-ascii?Q?4DMgYakCYF0jJkclRgWdNAN/X3ufFsue9yP4fIzM7ByLR6CPfYTCokswhGKd?=
 =?us-ascii?Q?DSAyVN5823CKx2XfoY4pioniOn90iJIgwknTHeuiXCVj1w4w+E359lOqXE9z?=
 =?us-ascii?Q?e2VUuaSHghlOxNd/S+1zh6x26TPOhQXELgSnFEvxADcc4VlYQlRLp/pUh1SB?=
 =?us-ascii?Q?9SezKhOkH4VexrjMA6hqcdO0ZGtxesLw0DJXMJqsS79tTGXirEgqFEvGfPWe?=
 =?us-ascii?Q?JDOcL4Q4GUDy/JVtKiL3GnULj7YdPATSRplj82vhpz/q3M/V9PvzAtW8vo4L?=
 =?us-ascii?Q?FAIoUzcnbelzr7JySOWlNxwQxUF6jYviHzrPxXFZjRMxZN4W1Ya+MB47SbpG?=
 =?us-ascii?Q?OhtikT+Kgg2+tj5nljUAPQPwK/iRJyrVfmEBFSCjB4I1+mKzBe0JU5eI+Qc8?=
 =?us-ascii?Q?fyRqf5v7Yatx5HxYC+xS7H+8FdlyY3HfYl4uX38UsHCpfyTrnZEzdvhqaguT?=
 =?us-ascii?Q?jEep581AbUADj1m9vqZYXZBNdxCOSJsTirK335AlWr5LdXp2AqOwvLk2gRxP?=
 =?us-ascii?Q?2u8fZeTVQKUkKXhhf9DmMNrItGbik7o87OwE0nIq+g7izshRfajg5SxhK2Cz?=
 =?us-ascii?Q?ZEPXYqcBKUIjDJ23MXpJQRuYrss8iEvn0s53zVbAQerH3QSyGBruVpgwvk/T?=
 =?us-ascii?Q?YUUAtB1G2U3aa3cjDBeOaNutiQ2IKf4LTk5y3sQn4m+bnB43iYkOvDy1NHcJ?=
 =?us-ascii?Q?m4TXOD8Cz1CkKv4epO1D3CjFpoPLIob8N7mbtFeWFPSOmSqhBHmh0Bpw568z?=
 =?us-ascii?Q?avU7qjz5OkrvAc54x0ENagTK6K2qGtXIUShJ8dVqJjOaCkznlcwjoZg77oB1?=
 =?us-ascii?Q?KHrDzpzRIh+apt+EovlvS4tcTXUyu3uvG0OFOK339Oe48q9AGZxY5FQ8thf3?=
 =?us-ascii?Q?nAOOeP7FGti7v92chmdpXBHbfHVUgSB+7hx/1IPC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d5f0e5-12ee-4fd1-fe93-08da5d790b90
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 04:52:49.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vm/OxMbSGm51ErGHvQHO1tWHBV7D95YwCdGO8ET5na0Ry7Kzq1+R7NTEi8fmdqhMBCSpARJeRgpjf5MbvH4yzMhzy8HSzhAWc+8emODezl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1889
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_03:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=990 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040020
X-Proofpoint-GUID: Sq2I1zsvy2T1KUvRe3_49kenJhU_G-8v
X-Proofpoint-ORIG-GUID: Sq2I1zsvy2T1KUvRe3_49kenJhU_G-8v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 02:32:09AM +0200, Angel Iglesias wrote:
> +/* Send a command to BMP3XX sensors */
> +static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
> +{
> +	int ret;
> +	unsigned int reg;
> +
> +	/* check if device is ready to process a command */
> +	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "failed to read error register\n");
> +		return ret;
> +	}
> +	if (!(cmd & BMP380_STATUS_CMD_RDY_MASK)) {

This looks like it should be "reg" instead of command?

> +		dev_err(data->dev, "device is not ready to accept commands\n");
> +		return -EBUSY;
> +	}
> +
> +	/* send command to process */
> +	ret = regmap_write(data->regmap, BMP380_REG_CMD, cmd);
> +	if (ret) {
> +		dev_err(data->dev, "failed to send command to device\n");
> +		return ret;
> +	}
> +	/* wait for 2ms for command to be proccessed */
> +	usleep_range(data->start_up_time, data->start_up_time + 100);
> +	/* check for command processing error */
> +	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "error reading ERROR reg\n");
> +		return ret;
> +	}
> +	if (reg & BMP380_ERR_CMD_MASK) {
> +		dev_err(data->dev, "error processing command 0x%X\n", cmd);
> +		return -EINVAL;
> +	}
> +	dev_dbg(data->dev, "Command 0x%X proccessed successfully\n", cmd);
> +
> +	return 0;
> +}

regards,
dan carpenter
