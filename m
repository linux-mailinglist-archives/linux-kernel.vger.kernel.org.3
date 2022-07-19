Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFAD57A5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiGSR6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiGSR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:58:31 -0400
Received: from esgaroth.petrovitsch.at (unknown [IPv6:2a01:4f8:120:527b:6876:2a4f:a044:62ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73F8491FD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:58:28 -0700 (PDT)
Received: from [172.16.0.14] (84-115-219-246.cable.dynamic.surfer.at [84.115.219.246])
        (authenticated bits=0)
        by esgaroth.petrovitsch.at (8.17.1/8.17.1) with ESMTPSA id 26JHwUEV2877090
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Tue, 19 Jul 2022 19:58:31 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 26JHwUEV2877090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=petrovitsch.priv.at;
        s=default; t=1658253512;
        bh=9j4wxf0e4cY2pX9V3YL1r2/aDHm4MaZ6EdMFSHFlysQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f8/iU1GM7uy/baxeg9Px4IShz+a+xRdigdqM8VDxl8fu4/OFIGpyRqzecxc3591Dr
         f3zZs7t/4WFQhClxm/GS1YDxHvVqQlqLNRoYTPkvZxk6nRJ7D0omJhA/fFy1QwqEyK
         FvOygdM8yR1QqKBXntKreYVxRnR2fI2C2HCaKkpI=
X-Info-sendmail: I was here
Message-ID: <9f95d37c-fe48-1ac4-902e-745542278005@petrovitsch.priv.at>
Date:   Tue, 19 Jul 2022 19:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] This is a send email test.
Content-Language: en-US
To:     Manyi Li <limanyi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, 545387015@qq.com
References: <20220719093108.21157-1-limanyi@uniontech.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
BIMI-Selector: v=BIMI1; s=default
In-Reply-To: <20220719093108.21157-1-limanyi@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: esgaroth.petrovitsch.priv.at 1102; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 11:31, Manyi Li wrote:
[...]
> 1th test

You have not passed the test because you didn't follow
the second paragrpah of http://vger.kernel.org/lkml/#s3

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
      There is NO CLOUD, just other people's computers. - FSFE
                      LUGA : http://www.luga.at
