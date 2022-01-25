Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A594449A8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1321036AbiAYDPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:15:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:17408 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1318508AbiAYDGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643079966; x=1674615966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6wiDFi+MUJGfBa7rNNA0k/UCTz9ezLG6tL1BwdVzifg=;
  b=QFFkyLe8BIcZuuTnIfiaX74GxnyK9zfeT/Rpr2TfACBEQWMC/5FAFuUG
   7qwa3KIpMAIFSg1t+Jqnm0ZT4g7vyXDFgsxOn4bo/Ji/+13gxutO5B2D+
   VhA+QbjJY+q/44vuTZMvXVqn+hD5cfP5PAbhNEDclZHUqYayfgaJ3HGc+
   C1HlZrXWrnecSI1NJ2o608/JsW6Ah7eyMxZSw4c318MhWKjY9E389oj1F
   eHkCMCfwT0WcRogF1R5x9bCtSx0PyzzqIqb+b9jK3Ng8xa3VMJZLmfnaR
   mH9x9c7eYjI5xo46FFgns983FQvaDWqm4qZsre/za6xjF3JJZHmcMmqaJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="332558730"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="332558730"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 18:56:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="627743489"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 18:56:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCC0J-000JGK-Pk; Tue, 25 Jan 2022 02:56:19 +0000
Date:   Tue, 25 Jan 2022 10:56:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2281/2384]
 drivers/media/test-drivers/vidtv/vidtv_channel.c:57:47: error: implicit
 declaration of function 'cpu_to_be32'
Message-ID: <202201251017.djjOySEy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: be7a8ba8c0f8e33e2dec022431f3d5b662dc5b9c [2281/2384] headers/deps: hashtable: Optimize <linux/hashtable_types.h> dependencies
config: mips-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220125/202201251017.djjOySEy-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=be7a8ba8c0f8e33e2dec022431f3d5b662dc5b9c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout be7a8ba8c0f8e33e2dec022431f3d5b662dc5b9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/ drivers/usb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/test-drivers/vidtv/vidtv_channel.c: In function 'vidtv_channel_s302m_init':
>> drivers/media/test-drivers/vidtv/vidtv_channel.c:57:47: error: implicit declaration of function 'cpu_to_be32' [-Werror=implicit-function-declaration]
      57 |         const __be32 s302m_fid              = cpu_to_be32(VIDTV_S302M_FORMAT_IDENTIFIER);
         |                                               ^~~~~~~~~~~
   drivers/media/test-drivers/vidtv/vidtv_channel.c: In function 'vidtv_channel_eit_event_cat_into_new':
>> drivers/media/test-drivers/vidtv/vidtv_channel.c:182:36: error: implicit declaration of function 'be16_to_cpu' [-Werror=implicit-function-declaration]
     182 |                         event_id = be16_to_cpu(curr->event_id);
         |                                    ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/cpu_to_be32 +57 drivers/media/test-drivers/vidtv/vidtv_channel.c

2f217729612c30 Mauro Carvalho Chehab 2020-09-20   50  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   51  /*
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   52   * init an audio only channel with a s302m encoder
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   53   */
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   54  struct vidtv_channel
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   55  *vidtv_channel_s302m_init(struct vidtv_channel *head, u16 transport_stream_id)
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   56  {
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  @57  	const __be32 s302m_fid              = cpu_to_be32(VIDTV_S302M_FORMAT_IDENTIFIER);
b9e09e06e32e61 Mauro Carvalho Chehab 2020-11-23   58  	char *event_text = ENCODING_ISO8859_15 "Bagatelle No. 25 in A minor for solo piano, also known as F\xfcr Elise, composed by Ludwig van Beethoven";
b9e09e06e32e61 Mauro Carvalho Chehab 2020-11-23   59  	char *event_name = ENCODING_ISO8859_15 "Ludwig van Beethoven: F\xfcr Elise";
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   60  	struct vidtv_s302m_encoder_init_args encoder_args = {};
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   61  	char *iso_language_code = ENCODING_ISO8859_15 "eng";
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   62  	char *provider = ENCODING_ISO8859_15 "LinuxTV.org";
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   63  	char *name = ENCODING_ISO8859_15 "Beethoven";
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   64  	const u16 s302m_es_pid              = 0x111; /* packet id for the ES */
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   65  	const u16 s302m_program_pid         = 0x101; /* packet id for PMT*/
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   66  	const u16 s302m_service_id          = 0x880;
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22   67  	const u16 s302m_program_num         = 0x880;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31   68  	const u16 s302m_beethoven_event_id  = 1;
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   69  	struct vidtv_channel *s302m;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   70  
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   71  	s302m = kzalloc(sizeof(*s302m), GFP_KERNEL);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   72  	if (!s302m)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   73  		return NULL;
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   74  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   75  	s302m->name = kstrdup(name, GFP_KERNEL);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   76  	if (!s302m->name)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   77  		goto free_s302m;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   78  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31   79  	s302m->service = vidtv_psi_sdt_service_init(NULL, s302m_service_id, false, true);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   80  	if (!s302m->service)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   81  		goto free_name;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   82  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   83  	s302m->service->descriptor = (struct vidtv_psi_desc *)
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   84  				     vidtv_psi_service_desc_init(NULL,
11f4933f7bc955 Mauro Carvalho Chehab 2020-11-23   85  								 DIGITAL_RADIO_SOUND_SERVICE,
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   86  								 name,
2f217729612c30 Mauro Carvalho Chehab 2020-09-20   87  								 provider);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   88  	if (!s302m->service->descriptor)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   89  		goto free_service;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   90  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   91  	s302m->transport_stream_id = transport_stream_id;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   92  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   93  	s302m->program = vidtv_psi_pat_program_init(NULL,
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   94  						    s302m_service_id,
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   95  						    s302m_program_pid);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   96  	if (!s302m->program)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21   97  		goto free_service;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   98  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21   99  	s302m->program_num = s302m_program_num;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  100  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  101  	s302m->streams = vidtv_psi_pmt_stream_init(NULL,
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  102  						   STREAM_PRIVATE_DATA,
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  103  						   s302m_es_pid);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  104  	if (!s302m->streams)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  105  		goto free_program;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  106  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  107  	s302m->streams->descriptor = (struct vidtv_psi_desc *)
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  108  				     vidtv_psi_registration_desc_init(NULL,
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  109  								      s302m_fid,
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  110  								      NULL,
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  111  								      0);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  112  	if (!s302m->streams->descriptor)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  113  		goto free_streams;
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  114  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  115  	encoder_args.es_pid = s302m_es_pid;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  116  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  117  	s302m->encoders = vidtv_s302m_encoder_init(encoder_args);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  118  	if (!s302m->encoders)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  119  		goto free_streams;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  120  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  121  	s302m->events = vidtv_psi_eit_event_init(NULL, s302m_beethoven_event_id);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  122  	if (!s302m->events)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  123  		goto free_encoders;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  124  	s302m->events->descriptor = (struct vidtv_psi_desc *)
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  125  				    vidtv_psi_short_event_desc_init(NULL,
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  126  								    iso_language_code,
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  127  								    event_name,
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  128  								    event_text);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  129  	if (!s302m->events->descriptor)
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  130  		goto free_events;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  131  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  132  	if (head) {
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  133  		while (head->next)
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  134  			head = head->next;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  135  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  136  		head->next = s302m;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  137  	}
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  138  
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  139  	return s302m;
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  140  
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  141  free_events:
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  142  	vidtv_psi_eit_event_destroy(s302m->events);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  143  free_encoders:
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  144  	vidtv_s302m_encoder_destroy(s302m->encoders);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  145  free_streams:
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  146  	vidtv_psi_pmt_stream_destroy(s302m->streams);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  147  free_program:
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  148  	vidtv_psi_pat_program_destroy(s302m->program);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  149  free_service:
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  150  	vidtv_psi_sdt_service_destroy(s302m->service);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  151  free_name:
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  152  	kfree(s302m->name);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  153  free_s302m:
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  154  	kfree(s302m);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  155  
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  156  	return NULL;
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  157  }
f90cf6079bf679 Daniel W. S. Almeida  2020-08-21  158  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  159  static struct vidtv_psi_table_eit_event
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  160  *vidtv_channel_eit_event_cat_into_new(struct vidtv_mux *m)
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  161  {
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  162  	/* Concatenate the events */
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  163  	const struct vidtv_channel *cur_chnl = m->channels;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  164  	struct vidtv_psi_table_eit_event *curr = NULL;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  165  	struct vidtv_psi_table_eit_event *head = NULL;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  166  	struct vidtv_psi_table_eit_event *tail = NULL;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  167  	struct vidtv_psi_desc *desc = NULL;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  168  	u16 event_id;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  169  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  170  	if (!cur_chnl)
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  171  		return NULL;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  172  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  173  	while (cur_chnl) {
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  174  		curr = cur_chnl->events;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  175  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  176  		if (!curr)
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  177  			dev_warn_ratelimited(m->dev,
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22  178  					     "No events found for channel %s\n",
a8bd461ca3b324 Mauro Carvalho Chehab 2020-09-22  179  					     cur_chnl->name);
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  180  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  181  		while (curr) {
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31 @182  			event_id = be16_to_cpu(curr->event_id);
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  183  			tail = vidtv_psi_eit_event_init(tail, event_id);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  184  			if (!tail) {
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  185  				vidtv_psi_eit_event_destroy(head);
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  186  				return NULL;
3be8037960bccd Mauro Carvalho Chehab 2020-09-21  187  			}
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  188  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  189  			desc = vidtv_psi_desc_clone(curr->descriptor);
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  190  			vidtv_psi_desc_assign(&tail->descriptor, desc);
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  191  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  192  			if (!head)
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  193  				head = tail;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  194  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  195  			curr = curr->next;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  196  		}
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  197  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  198  		cur_chnl = cur_chnl->next;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  199  	}
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  200  
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  201  	return head;
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  202  }
7a7899f6f58e32 Daniel W. S. Almeida  2020-10-31  203  

:::::: The code at line 57 was first introduced by commit
:::::: f90cf6079bf67988f8b1ad1ade70fc89d0080905 media: vidtv: add a bridge driver

:::::: TO: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
