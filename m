Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9E51761A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386727AbiEBRs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiEBRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:48:55 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD0658C;
        Mon,  2 May 2022 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1651513524; i=@lenovo.com;
        bh=0GKG9YhyYgnKod5OwcIXTzhTKzPlNhcucZJRJH4Jwps=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=TiXRZ+ifW7aeZpZ2nEHRBY3CznRV5oBtYmEjQdclH3jV/RYXz/SVP5fRGqTi6NLf3
         OVK5BqvEUJ9I1BuulIJEroT2SMlD8pSrEOL3moIie/j+9OzsMgZHvA0fwFIzDlYXqz
         qXwng4ri5qk4JUjHsBF5OzvS1QOjwJYKH3t6mC2LVmnO2xOKrjiWSu9XskelXcqwUA
         k7nZdc9Ow8r6whpO0kw08GQH0DRrlDguDo1aq3wR6oZ/9xQuWRPWgYdazQ9B3zm9SA
         VmTXs4I0izs/j5GewpKBlttn3AB5OBUu8FRy9Xia1TlD1iwKFPc5c4DfLYCFqfHO78
         KWDwCdOsdqGJQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTf0wbZRjud9crx0LN0Q742gBmnTNTvEoRt25
  xiv9I0ZhI4pyiUa7r0V5tS+2VDYzGDoLYUQIb65BSdZDNAGNUOiobpZQVyGDIxijifqhRRyLr
  hhgXo6wxse11iP89z/s87/s+b/J9OCpaFUhxutpKW0yUQSbYxNc9aSLJs9CszvdFC5R3L7YhS
  k+0h6/sGH9G2XDHB5ThYbdA6fQ3Y8ox53FUeXpkGS3CVdExoPL22gUq/4l7iGp19FuB6p439x
  WsDGNM6srqckzX038eMbdIq0+O/yGwgdrMw2ATDohTKPyzP8A/DFJjpAuDI95yTrAjsKuxXRA
  nIqIdgf5pG8aRUQRG/3Fj8RZIXASwsbeYE+wA+n1/J1taEDhT70A5cgtA9/d3sHUy6vAnVgqJ
  PbCtYS4ljvnEI/DC706Mq6fD6falhCeD2Acbg8FEXUzo4RHHpCCOUSIL3lj6AonjzcR70NXdy
  o8vQAk/gEN93yW3XQZwzvU5GncJiDw4OHg/0Z1KqGB0bCiFm/QYrB+KJvHDsM7XkfCLiK3wfv
  MVlLt0C3Qf+gxwuBzWHZtMYglcvM5dAIkcODnr5nP4ZVh3+1asF49hEtoG1FzZAKeCTcnWXHi
  p6TLSAkjXhptdG25zbUjn2pDuBOD3gt1qC6PVWY0UYyAV+fmkQlFI7igklQo59T5JyatYkqZY
  K1kgpw6ycppl5WyNcb9BIzfRVi+IvTSNpaj0HFjpXpOHgARHZBnCfrFZLXpIXamp0VGs7h1Ll
  YFmQ2A7jhMLFyY6gJRvqjTRMih8Pe5Lt9BaurqCMcTe7gMrxNNkm4Vp6TFZyJopI8toOekSeA
  pf+DoQQPH50EIAFSUmSbOEkcyYlYhbdVWm9UEP/sE8yJGKhYDH44nSzLTFyFj/r0dAFg5kYuH
  erNiUNMZkXd8XiUVBYlFqtcZ4FCv1nyS1ISWL4TN/4UTnj/YJT/e2vI/1sxVdVPHpwRpUYrMM
  HjV3vJDCu7p1p3Fh5ZO+7F3DjhcH6CvOqV/FZbavJvK0P4NdixldqePYgas3tdu1a27esXMHv
  jkoGZJHUp9f1jynua1vPA6utb777JRS2rPis3+YsTyvmStYK9sRbCjue83wZbDk09q9IRuzOr
  sGtzHMb57iU/a3lpZdwZKTN4rObPnJ8+hdr2fPcOYInl1Tn995KHD2ievlHwkq9W9MHW3rnd8
  3x/sByY18kBcsldzMcbaG0RXHcLizT3y+wqYPF87sL72mWlWHwq+WPm2azp5uCrzdhO1smHnz
  SMrYL7sHXjI1y/isjlI8jlpY6l8MYL3kggQAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-2.tower-715.messagelabs.com!1651513522!14892!1
X-Originating-IP: [104.47.110.45]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28556 invoked from network); 2 May 2022 17:45:23 -0000
Received: from mail-tyzapc01lp2045.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) (104.47.110.45)
  by server-2.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 May 2022 17:45:23 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVP7xigZvJbV61q29QEWxGdgmKQ+dv0mQspm1Mwnns/Vf/0jXR/QHqGSSiXqCnk+zPeh69uQx9f88U0hcrD4fmU0Um6DCo4IBb67ZfazhSNTx8N+yqOlX8udLcfdhsc4JvJALNlPluMGByyPpcJNShdF/hqQoaBVR393vayhcD8VilnWFIlBK9zfLBZFR5dDOLPc21tksy4IazwXE5O1RvCYKQMPqF0GXZgb4g9y96DIQW+1bahfKtqMghWPwdOmsgLL8OOUcQlLbZa6LKNDbsEJ2SaDU4YKwnR8bahMS//FE0bTknIXhs/QWIRGBPbiRMenfBKzvSk8VQ+doOb53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GKG9YhyYgnKod5OwcIXTzhTKzPlNhcucZJRJH4Jwps=;
 b=e3wpGydcKx8ZplE9vjyVzp4BCFANYjVkvjAfwlQpy8aa5wYU+eNwnrSLpvKFvV7dlbjmHxQeXJZnB0Kgwlh4PFXva4tgI2aqWVenzuU1b8TGLvp8YPA49L3Psz2g/wWdU5CE70lURt+PEF+qJ4GTrgoPXB8yqZV6V+HuaONzPc+pB0ybovG9YtPWmFcU1uwmMO5Zt0XJ5Q1hpGuwPs+OhEC71Bnlgz64AWaoG4EBh5NOXblEZT2GXEq4NAn0gUEF+MILDZylJkRp05TfVMVTuq76ErWCiXKt5izUPsC86yP5UQ+jSPtDsMtS2VobMsKaQME/UdoKCQ29If9tc9fq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SG2PR03CA0119.apcprd03.prod.outlook.com (2603:1096:4:91::23) by
 SG2PR03MB4976.apcprd03.prod.outlook.com (2603:1096:4:d8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Mon, 2 May 2022 17:45:21 +0000
Received: from SG2APC01FT0047.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:91:cafe::9) by SG2PR03CA0119.outlook.office365.com
 (2603:1096:4:91::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.14 via Frontend
 Transport; Mon, 2 May 2022 17:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 SG2APC01FT0047.mail.protection.outlook.com (10.13.36.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 17:45:20 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 2 May
 2022 13:44:57 -0400
Received: from [10.46.213.103] (10.46.213.103) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 2 May
 2022 13:46:03 -0400
Message-ID: <d7a35afb-6b3a-7d76-0dc1-975842407fea@lenovo.com>
Date:   Mon, 2 May 2022 13:44:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [External] [PATCH 1/2] platform/x86: thinkpad_acpi: Restore X1
 Carbon 9th Gen dual fan quirk
Content-Language: en-US
To:     Lyude Paul <lyude@redhat.com>,
        <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
References: <20220429211418.4546-1-lyude@redhat.com>
 <20220429211418.4546-2-lyude@redhat.com>
 <d3461670-a905-4956-4f4d-d847adf4289b@lenovo.com>
 <2769588a352e9c3b43a4e09afff100d52a9ba524.camel@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <2769588a352e9c3b43a4e09afff100d52a9ba524.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.46.213.103]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 412bcce7-8a46-46c9-7a3a-08da2c638765
X-MS-TrafficTypeDiagnostic: SG2PR03MB4976:EE_
X-Microsoft-Antispam-PRVS: <SG2PR03MB4976CE2245F6672BE5403192C5C19@SG2PR03MB4976.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7Qx4DpJO6igBDROe1t4p9XaSG6tTerAaaS9g/obwJMCrIpyJ6yAjEOm+xXSsxZuek2kzioAF++2wnNFXf+NwENrK+pEp5s/xSE+3M/8ySBjGSl3yLWFTY/kjc0BsriIJWwlRS7MzcCQLtupQsa+dCXqS9uqWkZsDt32l/+AJjkFdi3DfmGNT3opMv1/fKIGwHbRDWAEAwZdSVjNoNfsbE3h6xurg3G5wEdhANGTE1rgxUmg1ZVp6TqVGxOxr6QsgpCTi/+kiJpFQlN4qiiv9b+kP4nZhnQiN9fYsZdd4EbCB1c3Vs9BwJzt0E9T9EkdMv46gqqkMx5C4CjiVpMsMYcrAozn1ozWrinBwOM/bG2TEEBs573oYf1EiF6kJyYbmcnASbPRX5EaUx6Xhe6fe6IInpD8G8o6+B+iLgvvfhDDEb3hE4gf3aA4MoyQKaz7eCVOzCVjkbTbarjrB4I9NoZv6RQ24p2Rds/+CPNzvREjJiE/aVsh1mJh6PKuvvxrH0+PB8x5WzMvIdCG6bPrM1qv9aNWZ9Bqj+htsbj8SG5fZnHnytFxb9PuI020iQpDEWKeKRKvSg3LenFg2cOqEATjIb3SDw4n/go40Dix9WXvtwfWZdmBB01hPAbl7bWp/JqIoetiUcBs7Jti6JM2XFY37AVhyliuwW1O4evsWWni3jiEZlMoQz68dk5Qb/6mgNBphYaUPhELYNAyrOzva+yzECuGh6Sy+8B5aF57DYDxNX5jBXqJY2LE/CFhCJKPrT+/OIv98YrJF0FNC4xodkSD+4YUAyh43acYmV1wIxoS9WtxdM2PSUVVEVKrUJRh
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(8936002)(82960400001)(508600001)(16576012)(54906003)(316002)(36906005)(31686004)(2906002)(83380400001)(356005)(36756003)(110136005)(6666004)(2616005)(70586007)(70206006)(47076005)(82310400005)(36860700001)(4326008)(8676002)(426003)(336012)(26005)(16526019)(186003)(5660300002)(86362001)(40460700003)(31696002)(53546011)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 17:45:20.6149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412bcce7-8a46-46c9-7a3a-08da2c638765
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0047.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB4976
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/22 13:42, Lyude Paul wrote:
> Some answers/comments down below
> 
> On Fri, 2022-04-29 at 21:25 -0400, Mark Pearson wrote:
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
>>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>>> Fixes: bf779aaf56ea ("platform/x86: thinkpad_acpi: Add dual fan probe")
>>> Cc: Mark Pearson <markpearson@lenovo.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
>>> Cc: Mark Gross <markgross@kernel.org>
>>> Cc: ibm-acpi-devel@lists.sourceforge.net
>>> Cc: platform-driver-x86@vger.kernel.org
>>> ---
>>>  drivers/platform/x86/thinkpad_acpi.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c
>>> b/drivers/platform/x86/thinkpad_acpi.c
>>> index c568fae56db2..9067fd0a945c 100644
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -8699,6 +8699,7 @@ static const struct tpacpi_quirk fan_quirk_table[]
>>> __initconst = {
>>>         TPACPI_Q_LNV3('N', '2', 'E', TPACPI_FAN_2CTL),  /* P1 / X1 Extreme
>>> (1st gen) */
>>>         TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),  /* P1 / X1 Extreme
>>> (2nd gen) */
>>>         TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),  /* P15 (1st gen) /
>>> P15v (1st gen) */
>>> +       TPACPI_Q_LNV3('N', '3', '2', TPACPI_FAN_2CTL),  /* X1 Carbon (9th
>>> gen) */
>>>         TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen)
>>> */
>>>         TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN), /* X1 Tablet (2nd
>>> gen) */
>>>  };
>> I just double checked this on my X1C9 - and it's working correctly. 2nd
>> fan is detected correctly.
>>
>> I'd rather understand why it's not working on your setup then just
>> re-introduce the quirk.
> 
> Of course! I figured as much, it's just easy to start conversations with a
> revert :P
> 
>>
>> What happens on your system when the
>>   res = fan2_get_speed(&speed);
>> is called? If that is failing it means your 2nd fan isn't responding and
>> that's not supposed to happen. Could you let me know if you get an error
>> code, if it happens every boot, etc
>> I assume when the function is called later it works successfully?
> 
> It definitely seems to happen every boot, not sure about the error code it
> returns. I will check and get you this info asap
> 
>>
>> Also please confirm which BIOS and EC version you have.
> 
> BIOS version N32ET75W (1.51) release date 12/02/2021, embedded controller is
> 0.1.32
> 
> 
Thanks!

Along with Thomas' notes I think I've found the problem (though still
bemused why I don't see the problem on my X1C9 and I tested on multiple
platforms previously...so it is somewhat weird).

Working on a fix - will try and have that out for review later today or
tomorrow.

Mark
