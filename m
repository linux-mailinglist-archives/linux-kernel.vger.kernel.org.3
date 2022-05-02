Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C46516FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385095AbiEBNHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiEBNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:07:38 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BA0186D1;
        Mon,  2 May 2022 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1651496647; i=@lenovo.com;
        bh=ZFGsgU4H2tMlDUffbgALUtwxbTL2Y2KoA8qaZZgjzz8=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Q4whP9xy9seAHnqW5F1FfVBnJ1ja+8UZo0l/+TcPu3lhgMtO3ANEY6QBq0s5XuuG4
         8VpQFiV4Z9h19XY9hdxhRB2ntXgN6jhYgWsYESQSh2H55BwfEX734RmGKznz3Ckftq
         nDy1WYPz4ssa+Ss5GD0TNnv8Kq22SyAM04TcRH24WQ4kxN8j/WTVn+IvUzSQijdZ/W
         rFmJMe+gGy4fPvv9UnGhFyiOrvGYJoh3zaj6VaS8QYgxQKqVdnbLckExgnLRfG3S1M
         x95NuS6jdKKbUK2mBz2T9DnSK0FxfJC2WOCKwvIT2nfXikJPM/Xl8HeycjqOEjfdJj
         lD26b6XTdZ1Bg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJsWRWlGSWpSXmKPExsWSoS+VqXvsWn6
  SwYw3yhZvjk9nslj/eyWLxezDNhbtr7cyWlzeNYfNYuruflaLA1OnMVus3vOC2eLQ2+lsDpwe
  vw8wemxa1cnmsXvBZyaP9/uusnnMXnKDxePzJrkAtijWzLyk/IoE1owHsz4xFjzkq9j5vrSB8
  Sd3FyMnB6PAUmaJvllWXYxcQPYiVomrqx4wQzjtTBLXL99gA3GEBBYySTz/vIURwjnIJDHp4m
  92kH4JgeOMEt2r3CESnYwSu7f+gGrpY5J4tvw+M4TzmFHi06lTjHDO5U+f2UD6eQVsJW4u+cI
  IYrMIqEgcP3KRFSIuKHFy5hMWEFtUIFyie/9+sLiwQJbExJ6jYL3MAuISt57MZwKxRQTMJSZc
  mQq2gFlgFdC1Z5+xQ2w7xCjRsukb2LVsAtoSW7b8Aurm4OAUsJHY+sMJYpCmROt2iIeYBeQlm
  rfOZgaxhQSUJX71n2eGeFRRYk7jXEYIO0GiecpRKFtS4trNC9DAkJU4enYOC4TtK7H36weouK
  7E0TfTWCHsHIkdL7ugbDmJU73nmCYw6s5C8vMsJL/NQnLeLCTnLWBkWcVonVSUmZ5RkpuYmaN
  raGCga2hoomtuqGtkYqqXWKWbqFdarJuaWFyia6SXWF6sl1pcrFdcmZuck6KXl1qyiRGY5lKK
  3L/uYOxb+VPvEKMkB5OSKK/J2fwkIb6k/JTKjMTijPii0pzU4kOMGhwcAlcOHpnNKMWSl5+Xq
  iTB+/4iUJ1gUWp6akVaZg4wFcOUSnDwKInwMl0BSvMWFyTmFmemQ6ROMVpyXNm2dy8zx4MTJ4
  HktfUL9jELgc2TEudVB2kQAGnIKM2DGwfLF5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfN
  6XQWawpOZVwK39RXQQUxABzWl54IcVJKIkJJqYLLLFL4Sptg7aflc8YtSX3a8OvOw7o7d5t5J
  5aePTOtUtYgSNlvKacQ2NbQyIfaaW4AG3+fk29JaVk1ZLD8FhO5tCAhcmmZySnJuQNqfZ0ZPX
  sadsIzpkTg4j4d/jrFekaeV+Q7B1Dn8szt6C8VrJkTv7mB15GJuaJ73av4Roe6mK5erWOazbQ
  7l6zs6s/TY5oqsGXvrtBmE3b5FGhzkPLHS/LzFrPkdMvZb/Z4YzzY99zV8+ezbdReT9RVSOVc
  dLJfe2ZXztq1uJ2de/HOpJwZFlpnOl79oWPf+iat53B9S9p255YyVljeXlcKEWS4bvH5c/Lr+
  C8O5LsOXr1iVT3zOP3H7juViwcmxF9z3KbEUZyQaajEXFScCABimtH2SBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-15.tower-635.messagelabs.com!1651496644!15696!1
X-Originating-IP: [104.47.26.105]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23800 invoked from network); 2 May 2022 13:04:06 -0000
Received: from mail-sgaapc01lp2105.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.105)
  by server-15.tower-635.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 May 2022 13:04:06 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU6mqfrTH+/754LS56Wd9OYmewb5o2cImkCy/ENYXqdZw8uZq8XBt8eiRyIV5B5D5S+bdvWw5/mFmoYc7IhXtzQ9/YktTIJOMfJtIjTdCzKUvHsbmwMYS/d5bKPst9AOI4Gm1kn8wmAStPScS4MvOW21seT+3RcrkEGCXMB15ypNf4W0+qWvsunRfn6QGdflCz8TqvccjmDZ3blqhMFPLZeuDWXVRp71zUiXGDr5s3YYIrJi0SqM4RMK63ToLh3TbfQabtnB1wwn6EuAOQpw4ea4FTDeO28gtmdnIUpchmarj+C7fNKYdcL5792NAek9ZSeazMqSk5RlZGOS6M+kNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFGsgU4H2tMlDUffbgALUtwxbTL2Y2KoA8qaZZgjzz8=;
 b=EuFxBr22ONRsm+DPza+n9Tyy//Xo87RfwoEN+JldT7KInXHrTADk8sZo99J41nZsAbdNufDuuqet+ehbWT2HB/p4hGooqTj30MlSgFt+0mXxnrRyjlWU1UZhIb989o20AC0ACq736yHb6S82yuoB/05HxqJhsOS9cMfWUnL2G2zLfkgzuGfizLKG1y66Idq67AU6XtGLLPJz6IKP+wHYEhT2gePAGARQC8hPBMbc093wmSxxhGMer5Gjqs94Pzxgryh1GLv7o8nXWLZf2A/lbLToeVMJP0RieIwfUldn6asmkfamzq8isI/Qi5YBNBC9IgUmvq856SbdVVySc6mVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=t-8ch.de smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from PS2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::20) by SI2PR03MB6686.apcprd03.prod.outlook.com
 (2603:1096:4:1e9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6; Mon, 2 May
 2022 13:04:03 +0000
Received: from PSAAPC01FT003.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:2d:cafe::b) by PS2PR01CA0008.outlook.office365.com
 (2603:1096:300:2d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 13:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 PSAAPC01FT003.mail.protection.outlook.com (10.13.38.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 13:04:02 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 2 May
 2022 09:04:00 -0400
Received: from [10.46.213.103] (10.46.213.103) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 2 May
 2022 09:05:06 -0400
Message-ID: <e817c995-8f06-c852-0f83-893cb350cb48@lenovo.com>
Date:   Mon, 2 May 2022 09:03:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [External] [PATCH 1/2] platform/x86: thinkpad_acpi: Restore X1
 Carbon 9th Gen dual fan quirk
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
CC:     Lyude Paul <lyude@redhat.com>,
        <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
References: <20220429211418.4546-1-lyude@redhat.com>
 <20220429211418.4546-2-lyude@redhat.com>
 <d3461670-a905-4956-4f4d-d847adf4289b@lenovo.com>
 <9270b2da-0cca-422f-8bf8-4b1fb9aa363c@t-8ch.de>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <9270b2da-0cca-422f-8bf8-4b1fb9aa363c@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.46.213.103]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41986483-7b38-4d81-1bc6-08da2c3c3b39
X-MS-TrafficTypeDiagnostic: SI2PR03MB6686:EE_
X-Microsoft-Antispam-PRVS: <SI2PR03MB66869A7D946392F2F6E1D812C5C19@SI2PR03MB6686.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6IQpX+KbB3XZTrebnuqOk+RCdBxa+I1z4e7P4Nn7HvLl5H890Ovcr/jBkdvNE6CZE6BO2LX7CcJ0hN7BqJqXC80/0ofIw5E2xXuaZGN0pn0TKLWvl87zbsul+5BIo63X/AXxRoDV0XlnfJ2SaG5kKHmp9OABNV1Co8nYUPcTf217aEwsg4do4zmtXWtrn/M4oikcJs1yqktXNbPMsQK7MOKYjpKzdYuk/+iHA6uhY4p314+q3TzQPyAr1WuOkGLFlZ+jSxB9qf2KzwTJN0G+mGU4zz2M4Y1yRfIk2/hJriwbLbYqKGUUs989khf7omLJ2P24AtGn1DjQ+4XhFJopZjqy/esuRXm7Q35RUs210YjxeE6MYe2qzRJqqGLQQqxW7mHpH8zKRAG/2CxIgalZOJj8VHBqCnYcIUOK6KwrV87+w6XxZdFFjZ47Qw7ZU0Pna+r7gvJJO6vJw/Wc6svIp86W3c/svYMLOd/ch4FBp8z1Jn36yjjl5i4hz0uHlu5ulsKBB+xC+FYYirN32oZ0IVgXMOGkJgzJ2inqnXamcT/iScaJM+p91yFSWCruQjGInvHT22Q7wG4XQSgvnmNodnBrWw+wTAnKTmpjfdyXgDwTimvLOVcMEA5xxtxmHT1XOrtAaPkVJ9WH1Up1n2sWEjAM0sS1Br5okYDS/STG9zN64uP5k6CXx/mYcmYuNuLzWhC31cPHqiTdUgrKJZSxPuz1xSz/HRo+/HwIE9DK5OAPk6GEPJ0s+4mSrCgwnw4SjrBpZpo/uRCwy69JsZaokSCgD1oGfhU+CWB2vULcCVubuzaD24F9DHnMAc9ANX4
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(66574015)(83380400001)(508600001)(31696002)(47076005)(16576012)(8936002)(316002)(356005)(53546011)(70586007)(70206006)(5660300002)(54906003)(16526019)(2616005)(36906005)(31686004)(186003)(336012)(86362001)(36860700001)(81166007)(2906002)(6916009)(82310400005)(426003)(8676002)(4326008)(82960400001)(26005)(6666004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 13:04:02.5073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41986483-7b38-4d81-1bc6-08da2c3c3b39
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT003.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6686
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/22 08:13, Thomas Weißschuh wrote:
> Hi Mark,
> 
> On 2022-04-29 21:25-0400, Mark Pearson wrote:
>> Hi Lyude
>>
>> On 4/29/22 17:14, Lyude Paul wrote:
>>> The new method of probing dual fan support introduced in:
>>>
>>> bf779aaf56ea ("platform/x86: thinkpad_acpi: Add dual fan probe")
>>>
>>> While this commit says this works on the X1 Carbon 9th Gen, it actually
>>> just results in hiding the second fan on my local machine. Additionally,
>>> I'm fairly sure this machine powers on quite often without either of the
>>> two fans spinning.
>>>
>>> So let's fix this by adding back the dual fan quirk for the X1 Carbon 9th
>>> Gen.
>>>
>> [..]
>>
>> I just double checked this on my X1C9 - and it's working correctly. 2nd
>> fan is detected correctly.
>>
>> I'd rather understand why it's not working on your setup then just
>> re-introduce the quirk.
>>
>> What happens on your system when the
>>   res = fan2_get_speed(&speed);
>> is called? If that is failing it means your 2nd fan isn't responding and
>> that's not supposed to happen. Could you let me know if you get an error
>> code, if it happens every boot, etc
>> I assume when the function is called later it works successfully?
> 
> I have the same issue.
> 
> To me it looks like this:
> 
> Probing for the second fan calls fan2_get_speed(), this calls
> fan_select_fan2() which in turn checks that tp_features.second_fan is set.
> But at this point in the tp_features.second_fan can not yet be set because it
> is either set from quirks or *after* the probing.
> 
> Maybe some of the matches for the quirk TPACPI_FAN_2FAN should also have
> matched this device?
> It doesn't do so on my device.
> 
>> Also please confirm which BIOS and EC version you have.
> 
> Linux: 5.17.5
> BIOS Revision: 1.51
> Firmware Revision: 1.32
> 
Thanks Thomas,
I'll go do some more digging on my system and see what I've missed.
Mark
