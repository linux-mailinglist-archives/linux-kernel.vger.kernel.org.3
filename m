Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9F0591616
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiHLTp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHLTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8C9A9AE;
        Fri, 12 Aug 2022 12:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22A31617CE;
        Fri, 12 Aug 2022 19:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556DAC433C1;
        Fri, 12 Aug 2022 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660333551;
        bh=K/hYL4L8RSPI4/i8ZxbHZZLwHg/HU34PvK7TmC7iLno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoQ4iPU+4jhn/KDn2cpqmLj5dzadvemKgs663Y04iGK+tnskL5Mub0ewJT9BT8GJY
         N4B48T7E/dsyo0LHpueCRRCBICRF97CPCUfsb1dTwXCfsaGed56owXAMhDi933EnRB
         bU+9wTfR90yAg5UDRFWJUrCZV9D3wHuJXiY7zRtHhVKcOsG10mHDmHAr614dPAXdZk
         ZRFyfISOTqhVBigvoi5vzMAatA5VJoOMRsLY+m6UtnZua1ya4RXZK0/EL1X3HqgHee
         4JmVsPaSq0Ha9n52xatL1LwRK2UONaAzDw1uctRIPG9bWtnYSpL+A5UgcXKEPWz70i
         lOCm6auGKjaJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96DC44035A; Fri, 12 Aug 2022 16:45:49 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:45:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf scripting python: Delete repeated word in comments
Message-ID: <Yvat7ULGLYdgz8sE@kernel.org>
References: <20220807160239.474-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807160239.474-1-dengshaomin@cdjrlc.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 07, 2022 at 12:02:39PM -0400, shaomin Deng escreveu:
> Delete the repeated word "into" in comments.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index adba01b7d9dd..107aeccbae30 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -131,7 +131,7 @@ static void handler_call_die(const char *handler_name)
>  }
>  
>  /*
> - * Insert val into into the dictionary and decrement the reference counter.
> + * Insert val into the dictionary and decrement the reference counter.
>   * This is necessary for dictionaries since PyDict_SetItemString() does not
>   * steal a reference, as opposed to PyTuple_SetItem().
>   */
> -- 
> 2.35.1
> 

-- 

- Arnaldo
