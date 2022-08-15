Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D52593173
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiHOPPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiHOPPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:15:04 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737321E08;
        Mon, 15 Aug 2022 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1660576502; i=@lenovo.com;
        bh=bmk/exeyJ9k0pyPTDzAUVeM545Da+oIJ42Iao6v1Mu8=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=3U2ksQT8EMLzkKJy/N9dZD1YE6yTxlLswDV3vffsw+rjW6kpLg1xdUVIc6JFqWho6
         v3cJteZBQKt6c2hMpe9/7441e8WrYxLj1wRnnr4xzRHdGFPhRdO/tTtr1iyf/jti1b
         ZBIEVwKFJtUnZkcuVdeOzXicRyUMs4OAeZknGdEUwokSRKz4rVnl4JQUOSusyx40Tu
         llXLex6IIbVElRbDXrnZpCccHMWY8ArNAliexrv3rFsRbHmmkpJCeVaFlilWW/4P3h
         W4DfqGwlJjrEosALHYEopRYUCpvfPH7guRrU1V6BHHjkZ5zjoeq5FBGomD9p7vAA/p
         JKfFMANgtlGsA==
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTe0xTZxjGOZeeHg2VQ6HhkwlqJ8u4tJah7MO
  xBBMvx12ZmQTmHLSj0C6lkJ7CwD8MGzNCi4JCUEqpUFASBEHG/TKwG3GAcpEJEcExVuZgQYyC
  QGfYWg469s+X33Oe733f503OR2L8Aa4nKU/VyjVqqUpIbMYVu9X+ogWZTSbJHg2BFd3DKHxS/
  SYcuDVMwNFrHRi0jH6LQ0ttFwozymoIeNZcjsPFn0Yw+KiuFYWr+qsEzDpfzoXDrUYCZtc2cG
  DFgzMYnDHEwaf1z1HYdsNMwLwnM1xofrjMhUs55zhhAvr69SWcNqSfJeii9CGcvlB4CaNbDBN
  cuqQumS7KLOTQZe0zKG3q+YTuLK7i0tb+XIye/+EeQT+r8w7nfcZRqmWJqTEcxeD341hStWtq
  Se93WDqSu0WHbCIR6goGcmtP6pDNdjZzwOmcfoQVOShoqxrGHIJPGVEwbfiLy4ouFNRP93Ac9
  YC6hQB95WHWyEJAW8MywYrzKChfuYmzwoqAonQd4ShZE3VNuxzMo94FVX19XAfjlA8oMJo47H
  dX0FNoxR0soCLBb1MX1tiNigKW2Rdr9zHKA4xZL6M6hCTdKQV4/OsuxyyMussBuuzi9cGLKCj
  NnMMcBQTlD+rrbWshNlH7wLlv2jG2kS843fT3etPtoGnOiLFBXwe2nAGM3XMnyL+2grIcAzLy
  uxGWt4KR+4Nclr1A9x0jzvKHwNY6ts4iYF6dJFj2Br1n+9f7bActNx7guUiAYcPOhg27GTbEM
  2yIV4Lglcg+mUYZr9AmSJUqUaBEIgoM3CMK3iMKkoilJ0VScTIjkksZregtsfRrRixnGDGTlv
  ClKlaslmvrEPv/HKsJ825GGitXxBZkK4kKBbyRoRUZf4ssMTZNIWUU0ZpklZyxINtIUgh4dTE
  2Gd9VI4+Xp8YpVfZX8dIGpLPQnVcebbd5TJI0gVHGs1YvEkL+0tjRgZEDLZ32M6tT14XxcXWi
  Wu7pwbv9qb2AchQoktWv2r18Z3cRL083HuLk5MR3TpJrEpTa//uziAeJCN14U1H2Ls5KtfbV1
  Fl7INQeSDyx5Aiklf5neaaj0Y0HUv6ApoKyN6ydRov/U9uqr18pddXH95EwYuCf8erio36TQX
  nly+Q7NzsE3RVf9Q39+cwlXxuaFtUb3oSpxCnWyv0+/DiBnwfhOdXFmCPjvTtMnCu/ByiOT/a
  dGFE/f0yU7qxxTQqW3DFs07svjOzdHzFkOqrQvLcy8dE9mUQY+vBQgdcXjeEv3j5wuGbHdOvn
  7WM5zXrvRfmRn8/oM6rdjg0PnmIuFQqC9KcOiY5Exu/gJnUvufSHOZ04CCNrj2fKAsYaYjTzx
  hST4RipdNsdzJsP1WGp2bEhe+OKI7j8y/cv6mDlx4sHx/N+/GCOjr690OwSWeuuT/Rddha8/5
  oQZxTSQD9Mw0j/BTt8Y6biBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-19.tower-635.messagelabs.com!1660576499!194!1
X-Originating-IP: [104.47.110.43]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11472 invoked from network); 15 Aug 2022 15:15:00 -0000
Received: from mail-tyzapc01lp2043.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) (104.47.110.43)
  by server-19.tower-635.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Aug 2022 15:15:00 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUu6zA6BYFsbShqR22XXiOjAVBUDBslzjiVzEE5TSvMIjZhZTYSoXT1AkfvMknW+jMtR7qhBTGw2GG2jFK4ft2Z3aK/DyA3helGcbdv7FaToZp4PZjmhUCYb+2DXhmxsKny8GdMKMFDu5MCRdsIK+r0RCZMAHTyygxbvPDem61OaqF7uhNqTA7W280sb0lXQU1stBY0mY+cIA+1rxsi//NDvr9o4XrcK2ryDJKCnAYD5/i/X/wE21UqCNKA+kvROE1TcAHYCyKzT/o7F981jYIuR7fZwXTpvz+oRcNMzdw5Q621jAFi5XNWH7KSzwiap5s/s+YpmsRG1rZQFYmjLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmk/exeyJ9k0pyPTDzAUVeM545Da+oIJ42Iao6v1Mu8=;
 b=YT6wRY8OIuXeF/duGJ5524edPcN+7PwHrV29JCdzI57SpvNaiTENHXYQ/XmkYmxy5qUdL6UkpbWfpl9vJxcLKBOofr8T1PSVoMlo2pvAadi78u8BJJPLkI/B9WmLAd7CjQqFoUSQ7YVURyeOKyOzK9NXOEt4q8ciRny8G4/9OyVXWb00l5y9gkDWbSks1nuFqA/igE+E2tw0y9ArtRXcJEFhPybUZ8/zh6vq8qw9Z0ujSmXiv+1sP2aSghA4AHhP0jMGVfXcTtiPM6bZ9R+qb85Q56VK9m/GJBhpRZlrkdy16Ki8tAdXliq/SP2rErETiyRPcAh2c1DJeQn9orbAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=ideasonboard.com
 smtp.mailfrom=lenovo.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=lenovo.com; dkim=none (message not signed); arc=none
Received: from SG2PR06CA0244.apcprd06.prod.outlook.com (2603:1096:4:ac::28) by
 HK0PR03MB3908.apcprd03.prod.outlook.com (2603:1096:203:3c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.14; Mon, 15 Aug 2022 15:14:57 +0000
Received: from SG2APC01FT0024.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:ac:cafe::40) by SG2PR06CA0244.outlook.office365.com
 (2603:1096:4:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Mon, 15 Aug 2022 15:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 SG2APC01FT0024.mail.protection.outlook.com (10.13.36.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 15:14:56 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.28; Mon, 15 Aug
 2022 11:14:54 -0400
Received: from [10.46.215.102] (10.46.215.102) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.28; Mon, 15 Aug
 2022 11:14:53 -0400
Message-ID: <9a396cc3-5b0f-6db3-bad5-b4d81ecdf834@lenovo.com>
Date:   Mon, 15 Aug 2022 11:14:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [External] Re: Missing MIPI IPU6 camera driver for Intel Alder
 Lake laptops
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        <linux-media@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
        <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@google.com>,
        "Andy Whitcroft" <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>,
        <it+linux-media@molgen.mpg.de>
References: <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com> <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com> <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com> <YvnvnL9pBAgWMgTk@kroah.com>
 <YvnwtN1SwQjilJ97@google.com> <YvnybHVFmpUJs4qi@kroah.com>
 <Yvn0o96K8j5gRaWM@google.com> <Yvn4aiVLzFMneZCc@pendragon.ideasonboard.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <Yvn4aiVLzFMneZCc@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.215.102]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ce1ecd6-7cfc-42dc-6115-08da7ed0e9bb
X-MS-TrafficTypeDiagnostic: HK0PR03MB3908:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCcALnHi6sb71gSyHFu7po7z2LJ7PRGa409phPQPDBf+Un11xRKasV62XSlqiYwMkekxv3ZCzwyeKzy2121LHtyBO9rACcEFOhnn8H7E3aPnpigJXz0CqJYHAo5ieC9/dNGZX/SSFZ1k70su9vRli3fop65HW+OEiID7SI9ULmMN4GFlIKws9jlMz6x/+s8nE22zzlqKuDb/ZoPNVNsSS8gUvFPYqGnt/2NkWauAVox6TUH8DlkpYLFpvOm+AW8OJGgxlrM3MRVW36ECb4CyBnOZI1wc2zFbYyQ8O8ieOTLXsOrL+SCnRKelU48RAapF5pZntmhAYE+78vUyw8JTawo4n48sgeqSHOoYmJlqPdUN/5qUcGE6HDPu1oqXnU97uSkbfvkPBxxXFMeJy+YQFK0U0F+3hqetTEnt6HD2ZOe1/0TOEKZZKDmgmVCYThwqwWtttvf8zjRGOp8ILo25eJL2dyZAeNw+Ke8Vi7iSp1XJuEdkcgjVy5KfIYcy6xjbQRC9zE1PRv5oQZ/g2rVH7zu6CQZrBgux+FWrTcC3VW0CEbtjX35sPbvtNOgud3wrII847cfRfhAOoq81FK3hYJ66/GVABl94uzgD6Oo1FjrRc9aZlOGDa9Jq4Y8744k9eeXKU2W/QnJdmEt6ElL14op0cozUgoGlUGM3D5Xhg/rqaCdY0kb5nG6OvSvH8GMC6nT8TIrN54A7F/BPVGZo+ksvr0m3x5x/n7M9AjjOJxm7XLsag0qKzS1cc68OemPg06Bmevo7KfrBZnkjJOu7IP/rVB68ftd2tHf0CqpuWutk50carwj7QIRDJS6UlTh0Bn8cG8NF+ob8k3orQEA7TGfxloj+nF2WCl2jzkqNQwfboIWFDi0fFd2bRQ/PWOQ0sn0O9RtQF4FXkl3LKYEifg==
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(40470700004)(46966006)(36840700001)(8676002)(8936002)(478600001)(40480700001)(36860700001)(4326008)(16526019)(82740400003)(70206006)(54906003)(70586007)(186003)(81166007)(47076005)(82310400005)(356005)(336012)(426003)(41300700001)(110136005)(36756003)(82960400001)(53546011)(31696002)(2906002)(40460700003)(31686004)(86362001)(7416002)(2616005)(5660300002)(316002)(16576012)(26005)(36906005)(83380400001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 15:14:56.0703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce1ecd6-7cfc-42dc-6115-08da7ed0e9bb
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0024.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3908
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 03:40, Laurent Pinchart wrote:
> On Mon, Aug 15, 2022 at 04:24:19PM +0900, Sergey Senozhatsky wrote:
>> On (22/08/15 09:14), Greg KH wrote:
>>>> Definitely not today. Someday, for sure :)
>>>>
>>>> I don't want to promise any timelines. But we are certainly not
>>>> talking "weeks", we are talking "months". Several months is a
>>>> realistic timeline.
>>>
>>> Ok, so getting this merged is a good year out at the best, realisticly 2
>>> years given that once you submit the first version for review, the real
>>> work will start happening.
>>
>> Well, nothing is really set in stone here. We may revisit our strategy,
>> say turn it upside down, and hit upstream mailing list as soon as possible
>> instead.
>>
>>> So I'll stick with my original statement, don't buy this hardware
>>   ... if you plan on running vanilla kernel. Otherwise do buy :)
> 
> If you want to run a proprietary OS.
> 
Not sure where best to jump in...but just to add some perspective from a
Lenovo perspective.

100% agreed - don't buy the platforms (X1 Carbon G10, X1 Yoga G7, X1
Nano G2) with the MIPI camera (called 'computer vision' on the Lenovo
site) if you plan to run Linux. We are disabling that config on our
Linux preload.

From the 'reaching out to the community' perspective that was flagged
earlier in the thread - I've been discussing MIPI with Red Hat,
Canonical and Intel for a year now. We knew it was going to be a problem
and in fairness to Intel they've been very clear that initially the
'workaround' was going to be available and that the full solution will
be coming later. I've had some disappointments with progress but I also
don't have the expertise to be able to solve it myself and fully
appreciate these things don't happen overnight. Intel have been working
with us on this and I appreciate their support.

If there are people I should be engaged with let me know and we can
discuss offline. Going forward - I guess the good news is we have some
platforms with MIPI on to work with....having HW usually helps. I'm also
very open to any ideas of suggestions for accelerating getting this done
and where Lenovo can help. We're limited on a technical resource side of
things, but we do have HW :)

Mark
