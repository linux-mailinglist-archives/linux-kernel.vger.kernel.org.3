Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B1555ABFF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiFYS2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 14:28:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34108 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiFYS2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 14:28:45 -0400
Received: from [172.19.1.40] (not.afront.org [50.126.75.182])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id C48B9837F000;
        Sat, 25 Jun 2022 11:28:44 -0700 (PDT)
Message-ID: <0bf1d366-348c-0f91-8f0a-fc9cc6228783@kernel.org>
Date:   Sat, 25 Jun 2022 11:28:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: possible trace_printk() bug in v5.19-rc1
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
 <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
 <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
 <20220624190819.59df11d3@rorschach.local.home>
 <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
 <20220625134552.08c1a23a@rorschach.local.home>
From:   John 'Warthog9' Hawley <warthog9@kernel.org>
In-Reply-To: <20220625134552.08c1a23a@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Sat, 25 Jun 2022 11:28:45 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/2022 10:45 AM, Steven Rostedt wrote:
> On Sat, 25 Jun 2022 17:15:07 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
> 
>> [root@manet ~]# cat /etc/redhat-release
>> Fedora release 35 (Thirty Five)
>> [root@manet ~]# trace-cmd version
>>
>> trace-cmd version 2.9.2 (not-a-git-repo)
> 
> Ug, that's very old. Fedora should be shipping 3.1.1 soon.
> 
> Right John? ;-)

I've got 3.0.2 in there right now (~3mo old) and I've started the builds 
on the latest tags (REALLY need to automate this!), probably have latest 
tags built/packaged by tonight.

https://copr.fedorainfracloud.org/coprs/warthog9/tracing/

- John "Warthog9" Hawley
