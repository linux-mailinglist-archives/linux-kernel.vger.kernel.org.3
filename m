Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD8A4ECB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349651AbiC3SFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349642AbiC3SFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE8A36152
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BAD860B7C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10593C340EC;
        Wed, 30 Mar 2022 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648663411;
        bh=w9XEGSu/fGpITJnjzqWoGhFbyc0mQc/kEiyLZzElZow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ExOfY69WPH7LO0pl6Q0ctOOIvzL5QTjHifpHGVW0SfXjQOgn025D5Lz8REAnqlCca
         CXArL+xjG08DkQ9HSSk17qYr2vqyaykB4ZveAYM93Dvs9Fh+nqZdOulWNlpQjKQ93p
         awXjVuMDDvnYWPUkvNSGEBP0jaueyjuNz/lfWrBXm+5zGWJTc85muPHrovvvO3zNnl
         CyIwe00mf4ktTLpueCBRbBQE6iUe64+vSdhA/oAZfd71YvyfLhbq/ylpFZM2RMGdUb
         KNQVqnqRbugdYsdzddWREIOE0tajcy6MFDSwqWBOhZgGguG2iQwAmKfYoEkvv2+Ipf
         Avd+DiITJD1bA==
Message-ID: <4ab174c2-8772-d543-9784-31b4660efd82@kernel.org>
Date:   Wed, 30 Mar 2022 13:03:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] firmware: stratix10-rsu & svc: extend RSU & svc driver
 to get DCMF status
Content-Language: en-US
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <be70b809-659e-9a7e-2819-c38450c1014e@kernel.org>
 <20220330094253.3248179-1-kah.jing.lee@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220330094253.3248179-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please look into --cover-letter for 'git format-patch'

On 3/30/22 04:42, kah.jing.lee@intel.com wrote:
> 
> Resent, missing out linux mailing list.
> 
> Thanks.
> KJ
> 
