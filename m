Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6905D58F5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiHKCJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHKCJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:09:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40CF844D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660183758; x=1691719758;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dM96oose4C0HQawd3YdS1GMZeBgzBrHo6uRaQLnpwGM=;
  b=GQb58CFAQDG+FqNGAdnwF5qsi8VcnXPqkxAj0KiIZmd+kRkfOQZPlEu7
   NmLtV2YiSWPZi2MEA5dktPOYITBlN/1WQO5Dc/1pYFY6eo2Zdc0ImBmw6
   x/iu8CG6Kg52rXepihlRR/yuZgHAEYMj7Ie3D6dqLlG1ls38Ze4fdMeym
   Gz3PDnNAJS32matCRbDZT7K3U0/y7KnESYU1eZH0gp2FQOSBvslr9+jS9
   6lBVVb7DJZHfXBGpdfAklgLQrxNm+bIE4Xm9YQfxb6ZmMqy4KrfKwOfbT
   iupGc0ypUp+mun0+K26EVKZjXWca1r3xtRLq/07UyeI3F9tBJDC6oiVRg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292494890"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="292494890"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="673512050"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2022 19:09:16 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLxdL-0000yE-1q;
        Thu, 11 Aug 2022 02:09:15 +0000
Date:   Thu, 11 Aug 2022 10:08:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quinn Tran <qutran@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>
Subject: drivers/scsi/qla2xxx/qla_os.c:336:5: sparse: sparse: symbol
 'ql2xdelay_before_pci_error_handling' was not declared. Should it be static?
Message-ID: <202208110904.5YFRlVai-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aeb6e6ac18c73ec287b3b1e2c913520699358c13
commit: d3117c83ba316b3200d9f2fe900f2b9a5525a25c scsi: qla2xxx: Wind down adapter after PCIe error
date:   8 weeks ago
config: microblaze-randconfig-s052-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110904.5YFRlVai-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3117c83ba316b3200d9f2fe900f2b9a5525a25c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d3117c83ba316b3200d9f2fe900f2b9a5525a25c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/scsi/qla2xxx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/qla2xxx/qla_os.c:336:5: sparse: sparse: symbol 'ql2xdelay_before_pci_error_handling' was not declared. Should it be static?

vim +/ql2xdelay_before_pci_error_handling +336 drivers/scsi/qla2xxx/qla_os.c

    56	
    57	int ql2xsecenable;
    58	module_param(ql2xsecenable, int, S_IRUGO);
    59	MODULE_PARM_DESC(ql2xsecenable,
    60		"Enable/disable security. 0(Default) - Security disabled. 1 - Security enabled.");
    61	
    62	static int ql2xenableclass2;
    63	module_param(ql2xenableclass2, int, S_IRUGO|S_IRUSR);
    64	MODULE_PARM_DESC(ql2xenableclass2,
    65			"Specify if Class 2 operations are supported from the very "
    66			"beginning. Default is 0 - class 2 not supported.");
    67	
    68	
    69	int ql2xlogintimeout = 20;
    70	module_param(ql2xlogintimeout, int, S_IRUGO);
    71	MODULE_PARM_DESC(ql2xlogintimeout,
    72			"Login timeout value in seconds.");
    73	
    74	int qlport_down_retry;
    75	module_param(qlport_down_retry, int, S_IRUGO);
    76	MODULE_PARM_DESC(qlport_down_retry,
    77			"Maximum number of command retries to a port that returns "
    78			"a PORT-DOWN status.");
    79	
    80	int ql2xplogiabsentdevice;
    81	module_param(ql2xplogiabsentdevice, int, S_IRUGO|S_IWUSR);
    82	MODULE_PARM_DESC(ql2xplogiabsentdevice,
    83			"Option to enable PLOGI to devices that are not present after "
    84			"a Fabric scan.  This is needed for several broken switches. "
    85			"Default is 0 - no PLOGI. 1 - perform PLOGI.");
    86	
    87	int ql2xloginretrycount;
    88	module_param(ql2xloginretrycount, int, S_IRUGO);
    89	MODULE_PARM_DESC(ql2xloginretrycount,
    90			"Specify an alternate value for the NVRAM login retry count.");
    91	
    92	int ql2xallocfwdump = 1;
    93	module_param(ql2xallocfwdump, int, S_IRUGO);
    94	MODULE_PARM_DESC(ql2xallocfwdump,
    95			"Option to enable allocation of memory for a firmware dump "
    96			"during HBA initialization.  Memory allocation requirements "
    97			"vary by ISP type.  Default is 1 - allocate memory.");
    98	
    99	int ql2xextended_error_logging;
   100	module_param(ql2xextended_error_logging, int, S_IRUGO|S_IWUSR);
   101	module_param_named(logging, ql2xextended_error_logging, int, S_IRUGO|S_IWUSR);
   102	MODULE_PARM_DESC(ql2xextended_error_logging,
   103			"Option to enable extended error logging,\n"
   104			"\t\tDefault is 0 - no logging.  0x40000000 - Module Init & Probe.\n"
   105			"\t\t0x20000000 - Mailbox Cmnds. 0x10000000 - Device Discovery.\n"
   106			"\t\t0x08000000 - IO tracing.    0x04000000 - DPC Thread.\n"
   107			"\t\t0x02000000 - Async events.  0x01000000 - Timer routines.\n"
   108			"\t\t0x00800000 - User space.    0x00400000 - Task Management.\n"
   109			"\t\t0x00200000 - AER/EEH.       0x00100000 - Multi Q.\n"
   110			"\t\t0x00080000 - P3P Specific.  0x00040000 - Virtual Port.\n"
   111			"\t\t0x00020000 - Buffer Dump.   0x00010000 - Misc.\n"
   112			"\t\t0x00008000 - Verbose.       0x00004000 - Target.\n"
   113			"\t\t0x00002000 - Target Mgmt.   0x00001000 - Target TMF.\n"
   114			"\t\t0x7fffffff - For enabling all logs, can be too many logs.\n"
   115			"\t\t0x1e400000 - Preferred value for capturing essential "
   116			"debug information (equivalent to old "
   117			"ql2xextended_error_logging=1).\n"
   118			"\t\tDo LOGICAL OR of the value to enable more than one level");
   119	
   120	int ql2xshiftctondsd = 6;
   121	module_param(ql2xshiftctondsd, int, S_IRUGO);
   122	MODULE_PARM_DESC(ql2xshiftctondsd,
   123			"Set to control shifting of command type processing "
   124			"based on total number of SG elements.");
   125	
   126	int ql2xfdmienable = 1;
   127	module_param(ql2xfdmienable, int, S_IRUGO|S_IWUSR);
   128	module_param_named(fdmi, ql2xfdmienable, int, S_IRUGO|S_IWUSR);
   129	MODULE_PARM_DESC(ql2xfdmienable,
   130			"Enables FDMI registrations. "
   131			"0 - no FDMI registrations. "
   132			"1 - provide FDMI registrations (default).");
   133	
   134	#define MAX_Q_DEPTH	64
   135	static int ql2xmaxqdepth = MAX_Q_DEPTH;
   136	module_param(ql2xmaxqdepth, int, S_IRUGO|S_IWUSR);
   137	MODULE_PARM_DESC(ql2xmaxqdepth,
   138			"Maximum queue depth to set for each LUN. "
   139			"Default is 64.");
   140	
   141	int ql2xenabledif = 2;
   142	module_param(ql2xenabledif, int, S_IRUGO);
   143	MODULE_PARM_DESC(ql2xenabledif,
   144			" Enable T10-CRC-DIF:\n"
   145			" Default is 2.\n"
   146			"  0 -- No DIF Support\n"
   147			"  1 -- Enable DIF for all types\n"
   148			"  2 -- Enable DIF for all types, except Type 0.\n");
   149	
   150	#if (IS_ENABLED(CONFIG_NVME_FC))
   151	int ql2xnvmeenable = 1;
   152	#else
   153	int ql2xnvmeenable;
   154	#endif
   155	module_param(ql2xnvmeenable, int, 0644);
   156	MODULE_PARM_DESC(ql2xnvmeenable,
   157	    "Enables NVME support. "
   158	    "0 - no NVMe.  Default is Y");
   159	
   160	int ql2xenablehba_err_chk = 2;
   161	module_param(ql2xenablehba_err_chk, int, S_IRUGO|S_IWUSR);
   162	MODULE_PARM_DESC(ql2xenablehba_err_chk,
   163			" Enable T10-CRC-DIF Error isolation by HBA:\n"
   164			" Default is 2.\n"
   165			"  0 -- Error isolation disabled\n"
   166			"  1 -- Error isolation enabled only for DIX Type 0\n"
   167			"  2 -- Error isolation enabled for all Types\n");
   168	
   169	int ql2xiidmaenable = 1;
   170	module_param(ql2xiidmaenable, int, S_IRUGO);
   171	MODULE_PARM_DESC(ql2xiidmaenable,
   172			"Enables iIDMA settings "
   173			"Default is 1 - perform iIDMA. 0 - no iIDMA.");
   174	
   175	int ql2xmqsupport = 1;
   176	module_param(ql2xmqsupport, int, S_IRUGO);
   177	MODULE_PARM_DESC(ql2xmqsupport,
   178			"Enable on demand multiple queue pairs support "
   179			"Default is 1 for supported. "
   180			"Set it to 0 to turn off mq qpair support.");
   181	
   182	int ql2xfwloadbin;
   183	module_param(ql2xfwloadbin, int, S_IRUGO|S_IWUSR);
   184	module_param_named(fwload, ql2xfwloadbin, int, S_IRUGO|S_IWUSR);
   185	MODULE_PARM_DESC(ql2xfwloadbin,
   186			"Option to specify location from which to load ISP firmware:.\n"
   187			" 2 -- load firmware via the request_firmware() (hotplug).\n"
   188			"      interface.\n"
   189			" 1 -- load firmware from flash.\n"
   190			" 0 -- use default semantics.\n");
   191	
   192	int ql2xetsenable;
   193	module_param(ql2xetsenable, int, S_IRUGO);
   194	MODULE_PARM_DESC(ql2xetsenable,
   195			"Enables firmware ETS burst."
   196			"Default is 0 - skip ETS enablement.");
   197	
   198	int ql2xdbwr = 1;
   199	module_param(ql2xdbwr, int, S_IRUGO|S_IWUSR);
   200	MODULE_PARM_DESC(ql2xdbwr,
   201			"Option to specify scheme for request queue posting.\n"
   202			" 0 -- Regular doorbell.\n"
   203			" 1 -- CAMRAM doorbell (faster).\n");
   204	
   205	int ql2xgffidenable;
   206	module_param(ql2xgffidenable, int, S_IRUGO);
   207	MODULE_PARM_DESC(ql2xgffidenable,
   208			"Enables GFF_ID checks of port type. "
   209			"Default is 0 - Do not use GFF_ID information.");
   210	
   211	int ql2xasynctmfenable = 1;
   212	module_param(ql2xasynctmfenable, int, S_IRUGO);
   213	MODULE_PARM_DESC(ql2xasynctmfenable,
   214			"Enables issue of TM IOCBs asynchronously via IOCB mechanism"
   215			"Default is 1 - Issue TM IOCBs via mailbox mechanism.");
   216	
   217	int ql2xdontresethba;
   218	module_param(ql2xdontresethba, int, S_IRUGO|S_IWUSR);
   219	MODULE_PARM_DESC(ql2xdontresethba,
   220			"Option to specify reset behaviour.\n"
   221			" 0 (Default) -- Reset on failure.\n"
   222			" 1 -- Do not reset on failure.\n");
   223	
   224	uint64_t ql2xmaxlun = MAX_LUNS;
   225	module_param(ql2xmaxlun, ullong, S_IRUGO);
   226	MODULE_PARM_DESC(ql2xmaxlun,
   227			"Defines the maximum LU number to register with the SCSI "
   228			"midlayer. Default is 65535.");
   229	
   230	int ql2xmdcapmask = 0x1F;
   231	module_param(ql2xmdcapmask, int, S_IRUGO);
   232	MODULE_PARM_DESC(ql2xmdcapmask,
   233			"Set the Minidump driver capture mask level. "
   234			"Default is 0x1F - Can be set to 0x3, 0x7, 0xF, 0x1F, 0x7F.");
   235	
   236	int ql2xmdenable = 1;
   237	module_param(ql2xmdenable, int, S_IRUGO);
   238	MODULE_PARM_DESC(ql2xmdenable,
   239			"Enable/disable MiniDump. "
   240			"0 - MiniDump disabled. "
   241			"1 (Default) - MiniDump enabled.");
   242	
   243	int ql2xexlogins;
   244	module_param(ql2xexlogins, uint, S_IRUGO|S_IWUSR);
   245	MODULE_PARM_DESC(ql2xexlogins,
   246			 "Number of extended Logins. "
   247			 "0 (Default)- Disabled.");
   248	
   249	int ql2xexchoffld = 1024;
   250	module_param(ql2xexchoffld, uint, 0644);
   251	MODULE_PARM_DESC(ql2xexchoffld,
   252		"Number of target exchanges.");
   253	
   254	int ql2xiniexchg = 1024;
   255	module_param(ql2xiniexchg, uint, 0644);
   256	MODULE_PARM_DESC(ql2xiniexchg,
   257		"Number of initiator exchanges.");
   258	
   259	int ql2xfwholdabts;
   260	module_param(ql2xfwholdabts, int, S_IRUGO);
   261	MODULE_PARM_DESC(ql2xfwholdabts,
   262			"Allow FW to hold status IOCB until ABTS rsp received. "
   263			"0 (Default) Do not set fw option. "
   264			"1 - Set fw option to hold ABTS.");
   265	
   266	int ql2xmvasynctoatio = 1;
   267	module_param(ql2xmvasynctoatio, int, S_IRUGO|S_IWUSR);
   268	MODULE_PARM_DESC(ql2xmvasynctoatio,
   269			"Move PUREX, ABTS RX and RIDA IOCBs to ATIOQ"
   270			"0 (Default). Do not move IOCBs"
   271			"1 - Move IOCBs.");
   272	
   273	int ql2xautodetectsfp = 1;
   274	module_param(ql2xautodetectsfp, int, 0444);
   275	MODULE_PARM_DESC(ql2xautodetectsfp,
   276			 "Detect SFP range and set appropriate distance.\n"
   277			 "1 (Default): Enable\n");
   278	
   279	int ql2xenablemsix = 1;
   280	module_param(ql2xenablemsix, int, 0444);
   281	MODULE_PARM_DESC(ql2xenablemsix,
   282			 "Set to enable MSI or MSI-X interrupt mechanism.\n"
   283			 " Default is 1, enable MSI-X interrupt mechanism.\n"
   284			 " 0 -- enable traditional pin-based mechanism.\n"
   285			 " 1 -- enable MSI-X interrupt mechanism.\n"
   286			 " 2 -- enable MSI interrupt mechanism.\n");
   287	
   288	int qla2xuseresexchforels;
   289	module_param(qla2xuseresexchforels, int, 0444);
   290	MODULE_PARM_DESC(qla2xuseresexchforels,
   291			 "Reserve 1/2 of emergency exchanges for ELS.\n"
   292			 " 0 (default): disabled");
   293	
   294	static int ql2xprotmask;
   295	module_param(ql2xprotmask, int, 0644);
   296	MODULE_PARM_DESC(ql2xprotmask,
   297			 "Override DIF/DIX protection capabilities mask\n"
   298			 "Default is 0 which sets protection mask based on "
   299			 "capabilities reported by HBA firmware.\n");
   300	
   301	static int ql2xprotguard;
   302	module_param(ql2xprotguard, int, 0644);
   303	MODULE_PARM_DESC(ql2xprotguard, "Override choice of DIX checksum\n"
   304			 "  0 -- Let HBA firmware decide\n"
   305			 "  1 -- Force T10 CRC\n"
   306			 "  2 -- Force IP checksum\n");
   307	
   308	int ql2xdifbundlinginternalbuffers;
   309	module_param(ql2xdifbundlinginternalbuffers, int, 0644);
   310	MODULE_PARM_DESC(ql2xdifbundlinginternalbuffers,
   311	    "Force using internal buffers for DIF information\n"
   312	    "0 (Default). Based on check.\n"
   313	    "1 Force using internal buffers\n");
   314	
   315	int ql2xsmartsan;
   316	module_param(ql2xsmartsan, int, 0444);
   317	module_param_named(smartsan, ql2xsmartsan, int, 0444);
   318	MODULE_PARM_DESC(ql2xsmartsan,
   319			"Send SmartSAN Management Attributes for FDMI Registration."
   320			" Default is 0 - No SmartSAN registration,"
   321			" 1 - Register SmartSAN Management Attributes.");
   322	
   323	int ql2xrdpenable;
   324	module_param(ql2xrdpenable, int, 0444);
   325	module_param_named(rdpenable, ql2xrdpenable, int, 0444);
   326	MODULE_PARM_DESC(ql2xrdpenable,
   327			"Enables RDP responses. "
   328			"0 - no RDP responses (default). "
   329			"1 - provide RDP responses.");
   330	int ql2xabts_wait_nvme = 1;
   331	module_param(ql2xabts_wait_nvme, int, 0444);
   332	MODULE_PARM_DESC(ql2xabts_wait_nvme,
   333			 "To wait for ABTS response on I/O timeouts for NVMe. (default: 1)");
   334	
   335	
 > 336	u32 ql2xdelay_before_pci_error_handling = 5;
   337	module_param(ql2xdelay_before_pci_error_handling, uint, 0644);
   338	MODULE_PARM_DESC(ql2xdelay_before_pci_error_handling,
   339		"Number of seconds delayed before qla begin PCI error self-handling (default: 5).\n");
   340	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
