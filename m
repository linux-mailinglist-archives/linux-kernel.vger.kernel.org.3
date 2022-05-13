Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB30D52639F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350226AbiEMOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348958AbiEMOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:16:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5EA1238B9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 377DAB82EA3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B058C34100;
        Fri, 13 May 2022 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652451385;
        bh=SYkn9zGIhMQEyuL3RqNsFdNhfRsxrsmv3qqoa+bwebE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6RCx4dSV7n5iEgt3zyxj06YYEmVzDC8nOK/VSY7OP8Xni3j0zimhoh101OTmQWdR
         6e9UYO8b4+MM55YHrtYKs5qzGuYydrTu1PkjljAWnlqlnADwhMYgVF9iFZ01cnt8AM
         38qCN8+VL8TCGuQCNyXewIa8dOpERGA0HwWusYsBfJgbkwu75H/cGhsFPiQmdW3KEy
         dWFCA3WXhi/AUDdrfXMv9enAmkjOAOvAcaF40Hixxqqyix8nU2Tjy3G3kyzFSYc7/X
         Aj75eCtY0ZUM/vXqeX4671WFrMAAxtUOUtKV33FOvqJytWG8CyksrHA/766SJcG+FK
         78oibi+xFq2LA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF271400B1; Fri, 13 May 2022 11:16:22 -0300 (-03)
Date:   Fri, 13 May 2022 11:16:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove unused machines__find_host()
Message-ID: <Yn5oNuj7UdCQcKlZ@kernel.org>
References: <20220513084459.6581-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513084459.6581-1-adrian.hunter@intel.com>
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

Em Fri, May 13, 2022 at 11:44:59AM +0300, Adrian Hunter escreveu:
> machines__find_host() does not exist. Remove declaration.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/machine.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index 0023165422aa..2b9fb34a38ca 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -162,7 +162,6 @@ void machines__process_guests(struct machines *machines,
>  
>  struct machine *machines__add(struct machines *machines, pid_t pid,
>  			      const char *root_dir);
> -struct machine *machines__find_host(struct machines *machines);
>  struct machine *machines__find(struct machines *machines, pid_t pid);
>  struct machine *machines__findnew(struct machines *machines, pid_t pid);
>  struct machine *machines__find_guest(struct machines *machines, pid_t pid);
> -- 
> 2.25.1

-- 

- Arnaldo
