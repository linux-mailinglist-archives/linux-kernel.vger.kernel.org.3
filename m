Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0250F1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbiDZHPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343706AbiDZHPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:15:17 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1D3A730;
        Tue, 26 Apr 2022 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1650957131;
  x=1682493131;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fO9Z+yHYY09DcsKMPz1mk/C4AZ0Cbm0swq59IvDbhoY=;
  b=SCkzJABVXlgSktYP3rSOsDwi/mLV55zFELINr2stJGY9ig1od8hPS9/Z
   Y5Go6k54/OxYAzKDMd2ITefeoxsAcFjtKkbWHyL/DYJznjF1dOIMWI44z
   C9E4U3U9DWRd4hUtliA9Pasc5FhUxjPIQcr6QCNEPYQLQhIANuudpMJGG
   aWAiOiikhxXWr31Gtkux2/TlBwpnrvvkAbGBy18YJCqL9wc8LjS+UA++G
   mmUuTyJ7yZO80dC1Z0as9tYJw5X8OMFXin5bFPEVV0bjbvsTCRWcMQKWc
   G6WGyIJ0NvdRizj44HfZFxz1Gs6SjRy0NqxHdUSmtY8WxzjEWt4bvTG3L
   g==;
Message-ID: <96d1e6ab-4faa-05b5-9894-af9971dc0e5e@axis.com>
Date:   Tue, 26 Apr 2022 09:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: linux-next: Fixes tag needs some work in the hwmon-staging tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Camel Guo <camel.guo@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220426082824.04f63d08@canb.auug.org.au>
From:   Camel Guo <camelg@axis.com>
In-Reply-To: <20220426082824.04f63d08@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 00:28, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    251a486d3a93 ("hwmon: (tmp401) Fix incorrect return value of tmp401_init_client")
> 
> Fixes tag
> 
>    Fixes: c825ca044988 ("hwmon: (tmp401) Add support of three advanced features")
> 
> has these problem(s):
> 
>    - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: a7e1e934855c ("hwmon: (tmp401) Add support of three advanced features")
> 

Saw that this Fixes tag has been removed from hwmon-staging. Sorry for 
the mess and thanks for this fix.
