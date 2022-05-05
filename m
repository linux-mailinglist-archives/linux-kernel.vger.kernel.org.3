Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C9F51C508
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381372AbiEEQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiEEQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FA5BE4C;
        Thu,  5 May 2022 09:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD7461E08;
        Thu,  5 May 2022 16:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC42C385AC;
        Thu,  5 May 2022 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651767691;
        bh=x90hLu7LnZk8VIOqzE22BovnKsc5+lpG3SaFPC44K0w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S3NHse42p6QoM4VRH4CzyDNCw3ki46BHxM3dtqIYvZamSTIoL5p87jyU0HpNR5LJK
         7/W/4TXxc7v0+Sov3X4fpz/64nSDs3rfgkBaopuGEvjhXFbH7nXlQcDm+cvHR0E+K3
         Go7EzL/f1zN/9cDklNce3ZDcUFTSRV3VQOGTTLdZhqh1ZUgwi9tP50m1jpVaMzxMfF
         cQFhVj13DU0BNONQug1DgtX1IoiyYAXqyC/p0reniZmAszy59QcIrY4xAzRc1h5a9Q
         Jc/xOpTWcuHnlkJVbqQIP2O/cpm6uSK3QDz49DqY4h0dCsvllLNBkS6hOLbJ6DBfzv
         7d7eLq1I2P26g==
Message-ID: <e5fec585-932f-db71-f435-3f837a177dbc@kernel.org>
Date:   Thu, 5 May 2022 18:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] rtla: Remove procps-ng dependency
Content-Language: en-US
To:     John Kacur <jkacur@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>
References: <a0f9f8c1030c66305c9b921057c3d483064d5529.1651220820.git.bristot@kernel.org>
 <cd9251-c95-b342-3694-777945cc374@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <cd9251-c95-b342-3694-777945cc374@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 18:16, John Kacur wrote:
> If we were to add a package that depended on it, it would then be 
> available at runtime. I would remove any references to RHEL in your 
> description, and just say you are reducing the dependency on this to 
> simply building rtla. 

If I try to install today, it is not there. I am not saying it would not be
there. It is an argument that it it not that used, and it is correct.

-- Daniel



