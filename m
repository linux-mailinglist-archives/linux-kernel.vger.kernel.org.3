Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E544B5213C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiEJLej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiEJLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:34:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545324EA08;
        Tue, 10 May 2022 04:30:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 921C61F8B4;
        Tue, 10 May 2022 11:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652182233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MBjlQI2uyibVlu7+Ejq7Z4/K5FS1DpSVUvjHPHaboy4=;
        b=Ex7tvOdMwC9HCxyktFuFnlGrHLjZ6vCkmEwN8xHkuNT59UdjniLk0s8XPUYPw2fEwohYhm
        DJyQhr5kfvEPDdW25tT5/mcCa02KeFf+1Lrq6ieRGWA3HGexK+pbbDk/PrPSNcnIK+VkwF
        XsxlcV0DVrTq35vWPRuY/jNHEqlkvCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652182233;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MBjlQI2uyibVlu7+Ejq7Z4/K5FS1DpSVUvjHPHaboy4=;
        b=wPe4gt5+vEYMpulFqg+80Bd2RNGxgVr2pSTrhDPX1imYT2oAyEUjMK6YnPjmmQLmSXhYoL
        gNs3gzmxIVqJcXCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82FAD13AA5;
        Tue, 10 May 2022 11:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9fz5H9lMemLTawAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 10 May 2022 11:30:33 +0000
Date:   Tue, 10 May 2022 13:30:33 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Kacur <jkacur@redhat.com>, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V3] rtla: Remove procps-ng dependency
Message-ID: <20220510113033.auxhunymxbhioi4z@carbon.lan>
References: <553032a74ccdb1e6ae4dda543b7c4430ce8fae1a.1652176288.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <553032a74ccdb1e6ae4dda543b7c4430ce8fae1a.1652176288.git.bristot@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:57:04AM +0200, Daniel Bristot de Oliveira wrote:
> +static int procfs_is_workload_pid(const char *comm_prefix, struct dirent *proc_entry)
> +{
> +	char buffer[MAX_PATH];
> +	int comm_fd, retval;
> +	char *t_name;
> +
> +	if (proc_entry->d_type != DT_DIR)
> +		return 0;
> +
> +	if (*proc_entry->d_name == '.')
> +		return 0;
> +
> +	/* check if the string is a pid */
> +	for (t_name = proc_entry->d_name; t_name; t_name++) {
> +		if (!isdigit(*t_name))
> +			break;
> +	}
> +
> +	if (*t_name != '\0')
> +		return 0;
> +
> +	snprintf(buffer, MAX_PATH, "/proc/%s/comm", proc_entry->d_name);
> +	comm_fd = open(buffer, O_RDONLY);
> +	if (comm_fd < 0)
> +		return 0;
> +
> +	memset(buffer, 0, MAX_PATH);
> +	retval = read(comm_fd, buffer, MAX_PATH);
> +
> +	close(comm_fd);
> +
> +	if (retval <= 0)
> +		return 0;
> +
> +	retval = strncmp(comm_prefix, buffer, strlen(comm_prefix));
> +	if (retval)
> +		return 0;
> +
> +	/* comm already have \n */
> +	debug_msg("Found workload pid:%s comm:%s", proc_entry->d_name, buffer);
> +
> +	return 1;
> +}
> +
> +/*
> + * set_comm_sched_attr - set sched params to threads starting with char *comm_prefix
> + *
> + * This function uses /procfs to list the currently running threads and then set the
> + * sched_attr *attr to the threads that start with char *comm_prefix. It is
>   * mainly used to set the priority to the kernel threads created by the
>   * tracers.
>   */
> -int set_comm_sched_attr(const char *comm, struct sched_attr *attr)
> +int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr)
>  {
> -	int flags = PROC_FILLCOM | PROC_FILLSTAT;
> -	PROCTAB *ptp;
> -	proc_t task;
> +	struct dirent *proc_entry;
> +	DIR *procfs;
>  	int retval;
>  
> -	ptp = openproc(flags);
> -	if (!ptp) {
> -		err_msg("error openproc()\n");
> -		return -ENOENT;
> +	if (strlen(comm_prefix) >= MAX_PATH) {
> +		err_msg("Command prefix is too long: %d < strlen(%s)\n",
> +			MAX_PATH, comm_prefix);
> +		exit(EINVAL);
>  	}
>  
> -	memset(&task, 0, sizeof(task));
> +	procfs = opendir("/proc");

Maybe you want to check if procfs is a valid handle before using it.

> +
> +	while ((proc_entry = readdir(procfs))) {
>  
> -	while (readproc(ptp, &task)) {
> -		retval = strncmp(comm, task.cmd, strlen(comm));
> -		if (retval)
> +		retval = procfs_is_workload_pid(comm_prefix, proc_entry);
> +		if (!retval)
>  			continue;
> -		retval = __set_sched_attr(task.tid, attr);
> -		if (retval)
> +
> +		/* procfs_is_workload_pid confirmed it is a pid */
> +		retval = __set_sched_attr(atoi(proc_entry->d_name), attr);
> +		if (retval) {
> +			err_msg("Error setting sched attributes for pid:%s\n", proc_entry->d_name);
>  			goto out_err;
> -	}
> +		}
>  
> -	closeproc(ptp);
> +		debug_msg("Set sched attributes for pid:%s\n", proc_entry->d_name);
> +	}
>  	return 0;
>  
>  out_err:
> -	closeproc(ptp);
> +	closedir(procfs);
>  	return 1;
>  }
>  
> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
> index fa08e374870a..5571afd3b549 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -6,6 +6,7 @@
>   * '18446744073709551615\0'
>   */
>  #define BUFF_U64_STR_SIZE	24
> +#define MAX_PATH		1024

linux/limits.h defined MAX_PATH as well, though as 4096. Maybe use that
definition? If you want to make it dynamic you could use fpathconf(fd,
_PC_PATH_MAX) but one could argue that is over engineering :)

Thanks for the fix. Anyway just nitpicking.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
